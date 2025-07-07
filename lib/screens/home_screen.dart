import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ronald_duck/screens/quest_screen.dart';
import 'package:ronald_duck/screens/shop_screen.dart';
import 'package:ronald_duck/screens/voice_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isEgg = true;

  void _toggleImage() {
    setState(() {
      _isEgg = !_isEgg;
    });
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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/images/avatar.png',
                            width: 40,
                            height: 40,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),

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
                              const Icon(
                                Icons.local_fire_department,
                                color: Colors.orange,
                              ),
                              const SizedBox(width: 4),
                              Text('100 XP', style: GoogleFonts.nunito()),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),

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
                              const Icon(
                                Icons.monetization_on,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 4),
                              Text('100', style: GoogleFonts.nunito()),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),

                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.settings),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Center(
                      child: GestureDetector(
                        onTap: _toggleImage,
                        child: Image.asset(
                          _isEgg
                              ? 'assets/images/ronald-egg.png'
                              : 'assets/images/ronald-child.png',
                          width: 250,
                          height: 250,
                        ),
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildBottomCard('assets/images/shop.png', 'Shop', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ShopScreen(),
                          ),
                        );
                      }),
                      _buildBottomCard('assets/images/voice.png', 'AI Voice', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VoiceScreen(),
                          ),
                        );
                      }),
                      _buildBottomCard('assets/images/quest.png', 'Quest', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const QuestScreen(),
                          ),
                        );
                      }),
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
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
