import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ronald_duck/screens/daily_streak/result_choice_screen.dart';
import 'dart:math';

import 'package:ronald_duck/widgets/top_spotlight_painter.dart'; // Import untuk menggunakan fungsi acak (Random)

class RewardChoiceScreen extends StatelessWidget {
  const RewardChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFF8ECB8),
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/images/bg-pattern.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          CustomPaint(painter: TopSpotlightPainter(), child: Container()),
          SafeArea(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -50,
                    child: Image.asset(
                      'assets/images/ronald-char.png',
                      width: 150,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 75.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topCenter,
                        children: [
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
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Mau diapakan 50 koin hadiahmu?',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ChoiceCard(
                                        onPress: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (
                                                    context,
                                                  ) => const ResultChoiceScreen(
                                                    title:
                                                        'Kamu Telah Menabung',
                                                    iconPath:
                                                        'assets/images/piggy-bank.png',
                                                    bonusText:
                                                        'Nabungmu berhasil dan kamu dapat +1 koin sebagai bonusnya!',
                                                  ),
                                            ),
                                          );
                                        },
                                        iconPath:
                                            'assets/images/piggy-bank.png',
                                        title: 'Tabung',
                                        subtitle: '( +1 )',
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: ChoiceCard(
                                        onPress: () {
                                          bool isSuccess = Random().nextBool();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (
                                                    context,
                                                  ) => ResultChoiceScreen(
                                                    title:
                                                        isSuccess
                                                            ? 'Investasimu Untung!'
                                                            : 'Investasimu Rugi',
                                                    iconPath:
                                                        'assets/images/dice.png',
                                                    bonusText:
                                                        isSuccess
                                                            ? 'Selamat! Kamu dapat +5 koin dari investasimu!'
                                                            : 'Yah, kamu rugi -2 koin. Coba lagi lain kali!',
                                                  ),
                                            ),
                                          );
                                        },
                                        iconPath: 'assets/images/dice.png',
                                        title: 'Investasi',
                                        subtitle: '( +5 atau -2 )',
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFC7A24A),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.info,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'Investasi bisa untung besar, tapi juga bisa buat rugi',
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
                            ),
                            child: Text(
                              'YUK PILIH!',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                              ),
                            ),
                          ),

                          Positioned(
                            top: 40,
                            right: 12,
                            child: InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              child: const CircleAvatar(
                                radius: 14,
                                backgroundColor: Color(0xFFC7A24A),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChoiceCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;
  final VoidCallback onPress;

  const ChoiceCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFFEF8E7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            CustomPaint(painter: TopSpotlightPainter(), child: Container()),
            Image.asset(iconPath, width: 48),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: const Color(0xFF6B4F2C),
              ),
            ),
            Text(
              subtitle,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
