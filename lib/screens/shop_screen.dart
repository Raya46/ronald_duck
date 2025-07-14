import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ronald_duck/widgets/shop_grid_item.dart';
import 'package:ronald_duck/widgets/shop_tab_item.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  int _selectedIndex = 0; // 0 for hat, 1 for glasses, 2 for shirt

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with spotlight effect
          Container(
            color: const Color(0xFF78B96A), // Green background
            child: CustomPaint(painter: SpotlightPainter(), child: Container()),
          ),
          SafeArea(
            child: Column(
              children: [
                // Top Bar
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
                          onPressed: () {
                            Navigator.pop(context);
                          },
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
                              Text('100', style: GoogleFonts.nunito()),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Ronald Duck Image
                Expanded(
                  child: Center(
                    child: Image.asset(
                      'assets/images/ronald-child.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
                // Tab Bar
                Container(
                  color: const Color(0xFFFFF5DD), // Header tab background color
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ShopTabItem(
                        imagePath: 'assets/images/hat.png',
                        isSelected: _selectedIndex == 0,
                        onTap: () {
                          setState(() {
                            _selectedIndex = 0;
                          });
                        },
                      ),
                      ShopTabItem(
                        imagePath: 'assets/images/glasses.png',
                        isSelected: _selectedIndex == 1,
                        onTap: () {
                          setState(() {
                            _selectedIndex = 1;
                          });
                        },
                      ),
                      ShopTabItem(
                        imagePath: 'assets/images/shirt.png',
                        isSelected: _selectedIndex == 2,
                        onTap: () {
                          setState(() {
                            _selectedIndex = 2;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                // Grid View
                Expanded(
                  child: Container(
                    color: const Color(0xFFF8ECB8), // Background grid color
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.8, // Adjust as needed
                          ),
                      itemCount: 9, // Example: 9 items
                      itemBuilder: (context, index) {
                        return const ShopGridItem(
                            imagePath: 'assets/images/pirate-hat.png', price: '100');
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
    final paint =
        Paint()
          ..color = Colors.white.withOpacity(
            0.3,
          ); // Adjust opacity for desired effect

    // Top-left spotlight
    var path1 = Path();
    path1.moveTo(0, 0);
    path1.lineTo(size.width * 0.3, 0);
    path1.lineTo(size.width * 0.2, size.height * 0.4);
    path1.lineTo(0, size.height * 0.3);
    path1.close();
    canvas.drawPath(path1, paint);

    // Top-right spotlight
    var path2 = Path();
    path2.moveTo(size.width, 0);
    path2.lineTo(size.width * 0.7, 0);
    path2.lineTo(size.width * 0.8, size.height * 0.4);
    path2.lineTo(size.width, size.height * 0.3);
    path2.close();
    canvas.drawPath(path2, paint);

    // Center spotlight (larger)
    var path3 = Path();
    path3.moveTo(size.width * 0.3, 0);
    path3.lineTo(size.width * 0.7, 0);
    path3.lineTo(size.width * 0.6, size.height * 0.6);
    path3.lineTo(size.width * 0.4, size.height * 0.6);
    path3.close();
    canvas.drawPath(path3, paint);

    // Draw small white stars/sparkles
    final sparklePaint = Paint()..color = Colors.white;
    _drawSparkle(canvas, Offset(50, 30), 5, sparklePaint);
    _drawSparkle(canvas, Offset(size.width - 70, 40), 4, sparklePaint);
    _drawSparkle(canvas, Offset(size.width / 2, 20), 6, sparklePaint);
    _drawSparkle(canvas, Offset(size.width * 0.2, 80), 3, sparklePaint);
    _drawSparkle(canvas, Offset(size.width * 0.8, 90), 5, sparklePaint);
    _drawSparkle(canvas, Offset(size.width * 0.4, 100), 4, sparklePaint);
    _drawSparkle(canvas, Offset(size.width * 0.6, 120), 3, sparklePaint);
  }

  void _drawSparkle(Canvas canvas, Offset center, double size, Paint paint) {
    canvas.drawCircle(center, size / 2, paint);
    canvas.drawRect(
      Rect.fromCenter(center: center, width: size * 1.5, height: size / 3),
      paint,
    );
    canvas.drawRect(
      Rect.fromCenter(center: center, width: size / 3, height: size * 1.5),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
