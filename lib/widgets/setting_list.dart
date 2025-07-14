import 'package:flutter/material.dart';

class SettingList extends StatelessWidget {
  final String title;
  final VoidCallback? onPress;
  const SettingList({super.key, required this.title, this.onPress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Color(0xFFFEFAF1),
      ),
      onPressed: onPress,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.timelapse, size: 24.0),
              SizedBox(width: 10),
              Text(title),
            ],
          ),
          const Icon(Icons.chevron_right, size: 24.0),
        ],
      ),
    );
  }
}
