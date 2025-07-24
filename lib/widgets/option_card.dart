import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OptionCard extends StatefulWidget {
  final String prefix;
  final String text;
  final VoidCallback? onTap;
  final bool isSelected;

  const OptionCard({
    super.key,
    required this.prefix,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<OptionCard> createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Card(
        color: widget.isSelected ? Colors.orange.shade200 : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: widget.isSelected ? Colors.orange : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: widget.isSelected ? Colors.orange : Colors.grey[300],
                child: Text(
                  widget.prefix,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: widget.isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(widget.text, style: GoogleFonts.nunito(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
