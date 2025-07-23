import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingList extends StatelessWidget {
  final String title;
  final IconData icon; // Tambahkan parameter untuk ikon
  final VoidCallback? onPress;

  const SettingList({
    super.key,
    required this.title,
    required this.icon,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: InkWell(
        onTap: onPress,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: const Color(0xFFFEFAF1),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 4),
                blurRadius: 10,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 24.0,
                    color: const Color(0xFFF39237), // Warna ikon oranye
                  ),
                  const SizedBox(width: 16),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF6B4F2C), // Warna teks coklat
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.chevron_right,
                size: 24.0,
                color: Color(0xFF6B4F2C),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
