import 'package:flutter/material.dart';

class TopSpotlightPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFFFD700).withOpacity(0.0),

              const Color(0xFFFFD700).withOpacity(0.6),
            ],
            stops: const [0.0, 1.0],
          ).createShader(Rect.fromLTWH(0, 0, size.width, size.height * 0.4));

    var path = Path();

    path.moveTo(size.width * 0.25, size.height * 0.45);

    path.lineTo(size.width * 0.75, size.height * 0.45);

    path.lineTo(size.width, 0);

    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
