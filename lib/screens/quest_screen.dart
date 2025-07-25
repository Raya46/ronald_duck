import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ronald_duck/screens/quest/game_hop_screen.dart';
import 'package:ronald_duck/screens/quest/quiz_screen.dart';

class QuestScreen extends StatelessWidget {
  const QuestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFF8ECB8),
            child: Opacity(
              opacity: 0.8,
              child: Image.asset(
                'assets/images/bg-pattern.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Material(
                        color: Colors.white,
                        shape: const CircleBorder(),
                        elevation: 4,
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          customBorder: const CircleBorder(),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.arrow_back,
                              size: 24,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        "Mainkan Game",
                        style: GoogleFonts.nunito(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  _buildQuestCard(
                    context: context,
                    title: "Kuis Cerdas Finansial",
                    topColor: const Color(0xFFFFD95A),
                    bottomColor: const Color(0xFF8BC34A),
                    images: [
                      Positioned(
                        top: 45,
                        left: 40,
                        child: Image.asset('assets/images/coin.png', width: 70),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Image.asset(
                          'assets/images/coin.png',
                          width: 100,
                        ),
                      ),
                      Positioned(
                        top: 45,
                        right: 40,
                        child: Image.asset('assets/images/coin.png', width: 70),
                      ),
                    ],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuizScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  _buildQuestCard(
                    context: context,
                    title: "Kwak-Kwak Tangkap!",
                    bottomColor: const Color(0xFF8BC34A),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFB8ECF8), Color(0xFFFAEC5F)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    images: [
                      Positioned(
                        top: 55,
                        left: 30,
                        child: Image.asset('assets/images/book.png', width: 60),
                      ),
                      Positioned(
                        top: 25,
                        left: 90,
                        child: Image.asset('assets/images/bom.png', width: 80),
                      ),
                      Positioned(
                        top: 50,
                        right: 80,
                        child: Image.asset('assets/images/coin.png', width: 70),
                      ),
                      Positioned(
                        top: 45,
                        right: 20,
                        child: Image.asset(
                          'assets/images/controller.png',
                          width: 70,
                        ),
                      ),
                    ],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GameHopScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestCard({
    required BuildContext context,
    required String title,
    Color? topColor,
    Gradient? gradient,
    required Color bottomColor,
    required List<Widget> images,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.black.withOpacity(0.5), width: 3),
      ),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: SizedBox(
          height: 250,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(color: topColor, gradient: gradient),
              ),

              Positioned.fill(
                child: ClipPath(
                  clipper: HillClipper(),
                  child: Container(color: bottomColor),
                ),
              ),

              ..._buildSparkles(5, 120),

              ...images,
              Positioned(
                bottom: 20,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.nunito(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Mainkan',
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSparkles(int count, double maxHeight) {
    final random = Random();
    return List.generate(count, (index) {
      return Positioned(
        left: random.nextDouble() * 300,
        top: random.nextDouble() * maxHeight,
        child: const Icon(Icons.circle, color: Colors.white, size: 12),
      );
    });
  }
}

class HillClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.5);
    path.quadraticBezierTo(
      size.width / 2,
      size.height * 0.3,
      size.width,
      size.height * 0.55,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
