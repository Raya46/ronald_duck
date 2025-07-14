import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSettingsCard extends StatelessWidget {
  final String title;
  final Widget child;

  const CustomSettingsCard({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none, // Izinkan tab keluar dari batas Stack
      children: [
        Container(
          // Margin atas untuk memberi ruang bagi tab agar tidak tertutup
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
          // Padding internal untuk konten di dalam kartu
          child: Padding(
            // Padding atas lebih besar untuk memberi jarak dari tab
            padding: const EdgeInsets.only(
              top: 48,
              left: 16,
              right: 16,
              bottom: 24,
            ),
            child: child, // Menampilkan konten (list button)
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
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
            title,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 22,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
