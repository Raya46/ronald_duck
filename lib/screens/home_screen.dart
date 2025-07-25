import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ronald_duck/models/game_schema.dart';
import 'package:ronald_duck/screens/daily_streak/daily_streak_screen.dart';
import 'package:ronald_duck/screens/quest_screen.dart';
import 'package:ronald_duck/screens/setting_screen.dart';
import 'package:ronald_duck/screens/shop_screen.dart';
import 'package:ronald_duck/screens/voice_screen.dart';
import 'package:ronald_duck/service/game_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final IsarService isarService = IsarService();
  final supabase = Supabase.instance.client;

  UserProfile? _userProfile;
  EquippedItems? _equippedItems;
  bool _isLoading = true;
  bool _isHatched = false;
  int _eggTaps = 5;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _animation = Tween<double>(begin: 0, end: 8)
      .chain(CurveTween(curve: Curves.elasticIn))
      .animate(_animationController)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      }
    });
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) {
      if (mounted) setState(() => _isLoading = false);
      return;
    }

    var userProfile = await isarService.getUserProfile(userId);

    if (userProfile == null) {
      try {
        final results = await Future.wait<dynamic>([
          supabase.from('profiles').select().eq('id', userId).single(),
          supabase
              .from('user_progress')
              .select()
              .eq('user_id', userId)
              .single(),
          supabase
              .from('user_inventory')
              .select('item_id')
              .eq('user_id', userId),
          supabase
              .from('equipped_items')
              .select()
              .eq('user_id', userId)
              .maybeSingle(),
        ]);

        final profileResponse = results[0] as Map<String, dynamic>;
        final progressResponse = results[1] as Map<String, dynamic>;
        final inventoryResponse = results[2] as List<dynamic>;
        final equippedResponse = results[3] as Map<String, dynamic>?;

        userProfile = UserProfile(
          supabaseUserId: profileResponse['id'],
          name: profileResponse['name'],
          parentPassword: profileResponse['parent_password'],
          phoneNumber: profileResponse['phone_number'],
          xp: progressResponse['xp'],
          coins: progressResponse['coins'],
          isHatched: progressResponse['is_hatched'] ?? false,
          lastDailyStreakClaim:
              progressResponse['last_daily_streak_claim'] != null
                  ? DateTime.parse(progressResponse['last_daily_streak_claim'])
                  : null,
          currentStreakDay: progressResponse['current_streak_day'],
        );
        await isarService.saveUserProfile(userProfile);

        final inventoryIds =
            inventoryResponse.map((inv) => inv['item_id'] as int).toSet();
        await isarService.syncUserInventory(userProfile, inventoryIds);

        if (equippedResponse != null) {
          final hat = await isarService.getShopItemBySupabaseId(
            equippedResponse['hat_id'] as int?,
          );
          final glasses = await isarService.getShopItemBySupabaseId(
            equippedResponse['glasses_id'] as int?,
          );
          final shirt = await isarService.getShopItemBySupabaseId(
            equippedResponse['shirt_id'] as int?,
          );

          final equippedItems =
              EquippedItems()
                ..hat.value = hat
                ..glasses.value = glasses
                ..shirt.value = shirt;

          await isarService.updateEquippedItems(userProfile, equippedItems);
        }
      } catch (e) {
        print("Error fetching full profile from Supabase: $e");
      }
    }

    await _loadLocalData(userId);

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadLocalData(String userId) async {
    _userProfile = await isarService.getUserProfile(userId);
    if (_userProfile != null) {
      await _userProfile!.equippedItems.load();
      _equippedItems = _userProfile!.equippedItems.value;

      if (_equippedItems == null) {
        await _refreshEquippedItemsFromSupabase(userId);
      } else {
        if (_equippedItems!.hat.value != null) {
          await _equippedItems!.hat.load();
        }
        if (_equippedItems!.glasses.value != null) {
          await _equippedItems!.glasses.load();
        }
        if (_equippedItems!.shirt.value != null) {
          await _equippedItems!.shirt.load();
        }
      }

      _isHatched = _userProfile!.isHatched;

      print(
        "Loaded equipped items: Hat: ${_equippedItems?.hat.value?.name}, Glasses: ${_equippedItems?.glasses.value?.name}, Shirt: ${_equippedItems?.shirt.value?.name}",
      );
    }
  }

  Future<void> _refreshEquippedItemsFromSupabase(String userId) async {
    try {
      final equippedResponse =
          await supabase
              .from('equipped_items')
              .select()
              .eq('user_id', userId)
              .maybeSingle();

      if (equippedResponse != null && _userProfile != null) {
        final hat = await isarService.getShopItemBySupabaseId(
          equippedResponse['hat_id'] as int?,
        );
        final glasses = await isarService.getShopItemBySupabaseId(
          equippedResponse['glasses_id'] as int?,
        );
        final shirt = await isarService.getShopItemBySupabaseId(
          equippedResponse['shirt_id'] as int?,
        );

        _equippedItems =
            EquippedItems()
              ..hat.value = hat
              ..glasses.value = glasses
              ..shirt.value = shirt;

        await isarService.updateEquippedItems(_userProfile!, _equippedItems!);
        print("Refreshed equipped items from Supabase");
      }
    } catch (e) {
      print("Error refreshing equipped items from Supabase: $e");
    }
  }

  void _onEggTapped() {
    if (_isHatched) return;
    _animationController.forward(from: 0);
    setState(() {
      _eggTaps--;
      if (_eggTaps <= 0) {
        _hatchEgg();
      }
    });
  }

  Future<void> _hatchEgg() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _isHatched = true;
      _userProfile?.isHatched = true;
    });

    if (_userProfile != null) {
      await isarService.saveUserProfile(_userProfile!);
      try {
        await supabase
            .from('user_progress')
            .update({'is_hatched': true})
            .eq('user_id', _userProfile!.supabaseUserId);
      } catch (e) {
        print("Error updating hatch status: $e");
      }
    }
  }

  Future<void> _navigateTo(Widget screen) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );

    if (result == true || screen is ShopScreen) {
      print("Refreshing data after navigation");
      await _fetchUserData();
      setState(() {});
    }
  }

  Future<void> _navigateToShop() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ShopScreen()),
    );

    print("Refreshing data from local DB after shop visit");
    final userId = supabase.auth.currentUser?.id;
    if (userId != null) {
      await _loadLocalData(userId);

      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            color: const Color(0xFFF8ECB8),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: ArcClipper(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                color: const Color(0xFF78B96A),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child:
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _buildStreakButton(),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildInfoCard(
                                      Icons.local_fire_department,
                                      Colors.orange,
                                      '${_userProfile?.xp ?? 0} XP',
                                    ),
                                    const SizedBox(width: 8),
                                    _buildInfoCard(
                                      Icons.star,
                                      Colors.amber,
                                      '${_userProfile?.coins ?? 0}',
                                    ),
                                  ],
                                ),
                              ),
                              _buildSettingsButton(),
                            ],
                          ),
                          Expanded(
                            child: Center(
                              child: AnimatedBuilder(
                                animation: _animation,
                                builder: (context, child) {
                                  return Transform.translate(
                                    offset: Offset(_animation.value, 0),
                                    child: child,
                                  );
                                },
                                child: GestureDetector(
                                  onTap: _onEggTapped,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(
                                        _isHatched
                                            ? 'assets/images/ronald-child.png'
                                            : 'assets/images/ronald-egg.png',
                                        width: 500,
                                        height: 500,
                                      ),

                                      if (_isHatched &&
                                          _equippedItems?.hat.value != null)
                                        Positioned(
                                          top: -70,
                                          child: Image.asset(
                                            _equippedItems!
                                                .hat
                                                .value!
                                                .assetPath,
                                            width: 300,
                                            height: 300,
                                            fit: BoxFit.contain,
                                          ),
                                        ),

                                      if (_isHatched &&
                                          _equippedItems?.glasses.value != null)
                                        Positioned(
                                          top: 60,
                                          child: Image.asset(
                                            _equippedItems!
                                                .glasses
                                                .value!
                                                .assetPath,
                                            width: 250,
                                            height: 250,
                                            fit: BoxFit.contain,
                                          ),
                                        ),

                                      if (_isHatched &&
                                          _equippedItems?.shirt.value != null)
                                        Positioned(
                                          top: 245,
                                          child: Image.asset(
                                            _equippedItems!
                                                .shirt
                                                .value!
                                                .assetPath,
                                            width: 300,
                                            height: 200,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildBottomCard(
                                'assets/images/shop.png',
                                'Shop',
                                () => _navigateToShop(),
                              ),
                              _buildBottomCard(
                                'assets/images/voice.png',
                                'AI Voice',
                                () => _navigateTo(const VoiceScreen()),
                              ),
                              _buildBottomCard(
                                'assets/images/quest.png',
                                'Quest',
                                () => _navigateTo(const QuestScreen()),
                              ),
                            ],
                          ),
                        ],
                      ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStreakButton() {
    return InkWell(
      onTap: () => _navigateTo(const DailyStreakScreen()),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/avatar.png', width: 40, height: 40),
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, Color color, String text) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 4),
            Text(text, style: GoogleFonts.nunito()),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsButton() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () => _navigateTo(const SettingScreen()),
      ),
    );
  }

  Widget _buildBottomCard(
    String imagePath,
    String text, [
    VoidCallback? onTap,
  ]) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset(imagePath, width: 60, height: 60),
              const SizedBox(height: 8),
              Text(text, style: GoogleFonts.nunito()),
            ],
          ),
        ),
      ),
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.2);
    path.quadraticBezierTo(size.width / 2, 0, size.width, size.height * 0.2);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldDelegate) => false;
}
