import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ronald_duck/screens/home_screen.dart';

class ResultChoiceScreen extends StatelessWidget {
  final String title;
  final String iconPath;
  final String bonusText;
  final int rewardCoins; // Parameter ini tetap ada

  const ResultChoiceScreen({
    super.key,
    required this.title,
    required this.iconPath,
    required this.bonusText,
    required this.rewardCoins, // Wajib diisi
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Lapis 1: Background Warna dan Pola
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
          // Lapis 2: Konten Utama (Efek Spotlight dihapus)
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Ikon di atas kartu
                    Image.asset(iconPath, width: 120),
                    const SizedBox(height: 16),
                    // Kartu Utama
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topCenter,
                        children: [
                          // Body Kartu
                          Container(
                            margin: const EdgeInsets.only(top: 28),
                            padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDFBC5F),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  offset: const Offset(0, 8),
                                  blurRadius: 15,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  title,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 32,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '$rewardCoins Koin', // Menggunakan nilai dinamis
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 28,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    bonusText,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF6B4F2C),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    // Mengganti tumpukan halaman dengan HomeScreen
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => const HomeScreen(),
                                      ),
                                      (Route<dynamic> route) => false,
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFF39237),
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(16),
                                  ),
                                  child: const Icon(
                                    Icons.home,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Header "YEAY!!"
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF39237),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              'YEAY!!',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Class TopSpotlightPainter dihapus dari file ini
