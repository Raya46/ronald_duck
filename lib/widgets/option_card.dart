import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OptionCard extends StatelessWidget {
  final String prefix;
  final String text;

  const OptionCard({super.key, required this.prefix, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: Colors.grey[300],
              child: Text(
                prefix,
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(text, style: GoogleFonts.nunito(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
