import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ronald_duck/screens/parent/parent_prize_screen.dart';

class ParentSettingScreen extends StatelessWidget {
  const ParentSettingScreen({super.key});

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
                                left: 16,
                                right: 16,
                                bottom: 24,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildSettingOption(
                                    context,
                                    icon: Icons.shopping_cart_outlined,
                                    iconColor: Colors.red.shade400,
                                    text: 'Limit Belanja Koin',
                                    onTap: () {},
                                  ),
                                  const SizedBox(height: 12),
                                  _buildSettingOption(
                                    context,
                                    icon: Icons.email_outlined,
                                    iconColor: Colors.blue.shade400,
                                    text: 'Kirim Laporan Mingguan',
                                    onTap: () {},
                                  ),
                                  const SizedBox(height: 12),
                                  _buildSettingOption(
                                    context,
                                    icon: Icons.lock_outline,
                                    iconColor: Colors.green.shade600,
                                    text: 'Ubah Pin Keamanan',
                                    onTap: () {},
                                  ),
                                  const SizedBox(height: 12),
                                  _buildSettingOption(
                                    context,
                                    icon: Icons.store_outlined,
                                    iconColor: Colors.purple.shade400,
                                    text: 'Toko Hadiah Pribadi',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) =>
                                                  const ParentPrizeScreen(),
                                        ),
                                      );
                                    },
                                  ),
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
                              'PENGATURAN',
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

  Widget _buildSettingOption(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String text,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 24),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  text,
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
