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

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final IsarService isarService = IsarService();
  final supabase = Supabase.instance.client;

  UserProfile? _userProfile;
  bool _isLoading = true;
  bool _isHatched = false;
  int _eggTaps = 5; // Jumlah ketukan untuk menetaskan telur

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
        .animate(_animationController)
      ..addStatusListener((status) {
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
        final response = await supabase.from('profiles').select().eq('id', userId).maybeSingle();
        final progressResponse = await supabase.from('user_progress').select().eq('user_id', userId).maybeSingle();

        if (response != null && progressResponse != null) {
          userProfile = UserProfile(
            supabaseUserId: response['id'],
            name: response['name'],
            parentPassword: response['parent_password'],
            phoneNumber: response['phone_number'],
            xp: progressResponse['xp'],
            coins: progressResponse['coins'],
            isHatched: progressResponse['is_hatched'] ?? false,
          );
          await isarService.saveUserProfile(userProfile);
        }
      } catch (e) {
        print("Error fetching profile from Supabase: $e");
      }
    }

    if (mounted) {
      setState(() {
        _userProfile = userProfile;
        _isHatched = userProfile?.isHatched ?? false;
        _isLoading = false;
      });
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
        await supabase.from('user_progress').update({'is_hatched': true}).eq('user_id', _userProfile!.supabaseUserId);
      } catch (e) {
        print("Error updating hatch status: $e");
      }
    }
  }

  // --- FUNGSI NAVIGASI YANG DIPERBARUI ---
  Future<void> _navigateTo(Widget screen) async {
    // Pindah ke halaman lain dan tunggu sampai kembali
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
    // Setelah kembali, panggil _fetchUserData untuk refresh data
    _fetchUserData();
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
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildStreakButton(),
                            _buildInfoCard(Icons.local_fire_department, Colors.orange, '${_userProfile?.xp ?? 0} XP'),
                            _buildInfoCard(Icons.star, Colors.amber, '${_userProfile?.coins ?? 0}'),
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
                                child: Image.asset(
                                  _isHatched
                                      ? 'assets/images/ronald-child.png'
                                      : 'assets/images/ronald-egg.png',
                                  width: 250,
                                  height: 250,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildBottomCard('assets/images/shop.png', 'Shop', () => _navigateTo(const ShopScreen())),
                            _buildBottomCard('assets/images/voice.png', 'AI Voice', () => _navigateTo(const VoiceScreen())),
                            _buildBottomCard('assets/images/quest.png', 'Quest', () => _navigateTo(const QuestScreen())),
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

  Widget _buildBottomCard(String imagePath, String text, [VoidCallback? onTap]) {
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
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
