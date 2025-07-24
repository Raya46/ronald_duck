import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ronald_duck/models/game_schema.dart';
import 'package:ronald_duck/service/game_service.dart';

import 'package:ronald_duck/widgets/shop_grid_item.dart';
import 'package:ronald_duck/widgets/shop_tab_item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final IsarService isarService = IsarService();
  final supabase = Supabase.instance.client;

  int _selectedIndex = 0; // 0: hat, 1: glasses, 2: shirt
  UserProfile? _userProfile;
  List<ShopItem> _shopItems = [];
  Set<int> _inventoryItemIds = {};
  EquippedItems? _equippedItems;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) {
      setState(() => _isLoading = false);
      return;
    }

    // 1. Ambil data dari Isar (lokal) dan perbarui UI
    await _loadLocalData(userId);
    setState(() => _isLoading = false);

    // 2. Sinkronisasi dengan Supabase di latar belakang
    _syncWithSupabase(userId);
  }

  // --- FUNGSI BARU UNTUK MEMUAT DATA LOKAL ---
  Future<void> _loadLocalData(String userId) async {
    _userProfile = await isarService.getUserProfile(userId);
    _shopItems = await isarService.getShopItems();
    if (_userProfile != null) {
      final inventory = await _userProfile!.inventory.toList();
      _inventoryItemIds =
          inventory
              .map((inv) => inv.item.value?.supabaseItemId ?? -1)
              .where((id) => id != -1)
              .toSet();

      // Cara yang benar untuk memuat IsarLink
      await _userProfile!.equippedItems.load();
      _equippedItems = _userProfile!.equippedItems.value;
    }
  }

  Future<void> _syncWithSupabase(String userId) async {
    try {
      final results = await Future.wait([
        supabase.from('shop_items').select(),
        supabase.from('user_inventory').select('item_id').eq('user_id', userId),
      ]);

      final itemsResponse = results[0] as List<dynamic>;
      final inventoryResponse = results[1] as List<dynamic>;

      final fetchedItems =
          itemsResponse
              .map(
                (item) => ShopItem(
                  supabaseItemId: item['id'],
                  name: item['name'],
                  type: ItemType.values.byName(item['type']),
                  assetPath: item['asset_path'],
                  price: item['price'],
                ),
              )
              .toList();

      final fetchedInventoryIds =
          inventoryResponse.map((inv) => inv['item_id'] as int).toSet();

      await isarService.saveShopItems(fetchedItems);

      if (mounted) {
        setState(() {
          _shopItems = fetchedItems;
          _inventoryItemIds = fetchedInventoryIds;
        });
      }
    } catch (e) {
      print("Error syncing with Supabase: $e");
    }
  }

  Future<void> _handleItemTap(ShopItem item) async {
    final isOwned = _inventoryItemIds.contains(item.supabaseItemId);
    if (isOwned) {
      _equipItem(item);
    } else {
      _purchaseItem(item);
    }
  }

  Future<void> _purchaseItem(ShopItem item) async {
    if (_userProfile == null) return;

    if (_userProfile!.coins >= item.price) {
      setState(() {
        _userProfile!.coins -= item.price;
        _inventoryItemIds.add(item.supabaseItemId);
      });

      await isarService.saveUserProfile(_userProfile!);
      await isarService.purchaseItem(_userProfile!, item);

      try {
        await supabase
            .from('user_progress')
            .update({'coins': _userProfile!.coins})
            .eq('user_id', _userProfile!.supabaseUserId);
        await supabase.from('user_inventory').insert({
          'user_id': _userProfile!.supabaseUserId,
          'item_id': item.supabaseItemId,
        });
      } catch (e) {
        print("Error syncing purchase: $e");
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item.name} berhasil dibeli!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Koin tidak cukup!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // --- FUNGSI INI TELAH DIPERBAIKI ---
  Future<void> _equipItem(ShopItem item) async {
    if (_userProfile == null) return;

    // Panggil service untuk menyimpan perubahan di database
    await isarService.equipItem(_userProfile!, item);

    // Setelah menyimpan, panggil kembali fungsi untuk memuat ulang semua data lokal
    await _loadLocalData(_userProfile!.supabaseUserId);

    // Perbarui state UI dengan data yang sudah fresh
    setState(() {});

    // TODO: Tambahkan logika untuk menyimpan item yang dipakai ke Supabase
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('${item.name} telah dipakai!')));
    }
  }

  List<ShopItem> get _filteredItems {
    final type = ItemType.values[_selectedIndex];
    return _shopItems.where((item) => item.type == type).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xFF78B96A),
            child: CustomPaint(painter: SpotlightPainter(), child: Container()),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber),
                              const SizedBox(width: 4),
                              Text(
                                _userProfile?.coins.toString() ?? '0',
                                style: GoogleFonts.nunito(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/images/ronald-child.png',
                          width: 200,
                          height: 200,
                        ),
                        // Menampilkan item yang dipakai
                        if (_equippedItems?.hat.value != null)
                          Image.asset(
                            _equippedItems!.hat.value!.assetPath,
                            width: 200,
                            height: 200,
                          ),
                        if (_equippedItems?.glasses.value != null)
                          Image.asset(
                            _equippedItems!.glasses.value!.assetPath,
                            width: 200,
                            height: 200,
                          ),
                        if (_equippedItems?.shirt.value != null)
                          Image.asset(
                            _equippedItems!.shirt.value!.assetPath,
                            width: 200,
                            height: 200,
                          ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: const Color(0xFFFFF5DD),
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ShopTabItem(
                        imagePath: 'assets/images/hat.png',
                        isSelected: _selectedIndex == 0,
                        onTap: () => setState(() => _selectedIndex = 0),
                      ),
                      ShopTabItem(
                        imagePath: 'assets/images/glasses.png',
                        isSelected: _selectedIndex == 1,
                        onTap: () => setState(() => _selectedIndex = 1),
                      ),
                      ShopTabItem(
                        imagePath: 'assets/images/shirt.png',
                        isSelected: _selectedIndex == 2,
                        onTap: () => setState(() => _selectedIndex = 2),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: const Color(0xFFF8ECB8),
                    child:
                        _isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : GridView.builder(
                              padding: const EdgeInsets.all(16.0),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 0.8,
                                  ),
                              itemCount: _filteredItems.length,
                              itemBuilder: (context, index) {
                                final item = _filteredItems[index];
                                final isOwned = _inventoryItemIds.contains(
                                  item.supabaseItemId,
                                );
                                return ShopGridItem(
                                  imagePath: item.assetPath,
                                  price: item.price.toString(),
                                  isOwned: isOwned,
                                  onTap: () => _handleItemTap(item),
                                );
                              },
                            ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SpotlightPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.3);

    var path1 = Path();
    path1.moveTo(0, 0);
    path1.lineTo(size.width * 0.3, 0);
    path1.lineTo(size.width * 0.2, size.height * 0.4);
    path1.lineTo(0, size.height * 0.3);
    path1.close();
    canvas.drawPath(path1, paint);

    var path2 = Path();
    path2.moveTo(size.width, 0);
    path2.lineTo(size.width * 0.7, 0);
    path2.lineTo(size.width * 0.8, size.height * 0.4);
    path2.lineTo(size.width, size.height * 0.3);
    path2.close();
    canvas.drawPath(path2, paint);

    var path3 = Path();
    path3.moveTo(size.width * 0.3, 0);
    path3.lineTo(size.width * 0.7, 0);
    path3.lineTo(size.width * 0.6, size.height * 0.6);
    path3.lineTo(size.width * 0.4, size.height * 0.6);
    path3.close();
    canvas.drawPath(path3, paint);

    final sparklePaint = Paint()..color = Colors.white;
    _drawSparkle(canvas, Offset(50, 30), 5, sparklePaint);
    _drawSparkle(canvas, Offset(size.width - 70, 40), 4, sparklePaint);
    _drawSparkle(canvas, Offset(size.width / 2, 20), 6, sparklePaint);
  }

  void _drawSparkle(Canvas canvas, Offset center, double size, Paint paint) {
    canvas.drawCircle(center, size / 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
