import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParentPrizeScreen extends StatelessWidget {
  const ParentPrizeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8ECB8),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black54),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),

                      child: Stack(
                        alignment: Alignment.topCenter,
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 28),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDFBC5F),
                              borderRadius: BorderRadius.circular(24.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 56,
                                left: 24,
                                right: 24,
                                bottom: 32,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildMainImage(),
                                  const SizedBox(height: 24),
                                  Text(
                                    'Belum ada hadiah',
                                    style: GoogleFonts.nunito(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Ayo buat hadiah pertamamu\nuntuk memotivasi Budi!',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  _buildAddButton(),
                                ],
                              ),
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF39237),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Text(
                              'TOKO HADIAH',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildMainImage() {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Image.asset('assets/images/ronald-wink.png', height: 150),

        Positioned(
          left: -40,
          bottom: 10,
          child: Image.asset('assets/images/prize.png', height: 100),
        ),

        Positioned(
          top: 10,
          left: -10,
          child: Icon(Icons.star, color: Colors.white, size: 20),
        ),
        Positioned(
          top: 20,
          right: -15,
          child: Icon(Icons.star, color: Colors.white, size: 24),
        ),
        Positioned(
          bottom: 5,
          left: 30,
          child: Icon(Icons.star, color: Colors.white, size: 16),
        ),
      ],
    );
  }

  Widget _buildAddButton() {
    return ElevatedButton.icon(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
      icon: const Icon(Icons.add, size: 24),
      label: Text(
        'Tambah Hadiah',
        style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
