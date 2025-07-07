import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OptionCard extends StatefulWidget {
  final String prefix;
  final String text;
  final VoidCallback? onTap;
  final bool isCorrect;

  const OptionCard({
    super.key,
    required this.prefix,
    required this.text,
    this.onTap,
    this.isCorrect = false,
  });

  @override
  State<OptionCard> createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
        widget.onTap?.call();
      },
      child: Card(
        elevation: 2,
        color: _isSelected ? const Color(0xFFF4C754) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: const Color(0xFFF8ECB8),
                child: Text(
                  widget.prefix,
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                widget.text,
                style: GoogleFonts.nunito(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
