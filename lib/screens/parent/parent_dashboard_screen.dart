import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class ParentDashboardScreen extends StatefulWidget {
  const ParentDashboardScreen({super.key});

  @override
  State<ParentDashboardScreen> createState() => _ParentDashboardScreenState();
}

class _ParentDashboardScreenState extends State<ParentDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF5E1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Dashboard",
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Ringkasan Aktivitas
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF39237),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  const Icon(Icons.bar_chart, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    'Ringkasan Aktivitas (7 Hari Terakhir)',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 3 Kartu Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Expanded(
                  child: InfoCard(
                    icon: Icons.access_time_filled,
                    iconColor: Colors.orange,
                    title: 'Waktu Belajar',
                    value: '3.5 Jam',
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: InfoCard(
                    icon: Icons.extension,
                    iconColor: Colors.blueAccent,
                    title: 'Game Selesai',
                    value: '12 Benar',
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: InfoCard(
                    icon: Icons.local_fire_department,
                    iconColor: Colors.redAccent,
                    title: 'Streak',
                    value: '6 Hari',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Grid Kartu Progress
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.9,
              children: const [
                ProgressCard(
                  title: 'Konsep Menabung',
                  percentage: 77,
                  status: 'Baik',
                  color: Color(0xFF5CB85C),
                ),
                ProgressCard(
                  title: 'Kebutuhan vs. Keinginan',
                  percentage: 87,
                  status: 'Baik',
                  color: Color(0xFFF0AD4E),
                ),
                ProgressCard(
                  title: 'Dasar Budgeting',
                  percentage: 92,
                  status: 'Sangat Baik',
                  color: Color(0xFFFFD700),
                ),
                ProgressCard(
                  title: 'Investasi & Risiko',
                  percentage: 32,
                  status: 'Perlu Belajar',
                  color: Color(0xFF5BC0DE),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Kartu Insight
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.lightbulb, color: Colors.amber, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Insight',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Budi cenderung sangat berhati-hati. Ini adalah fondasi yang bagus! Ajak ia bicara tentang manfaat mengambil risiko kecil.',
                          style: GoogleFonts.poppins(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// WIDGET UNTUK 3 KARTU INFO DI ATAS
class InfoCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;

  const InfoCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// WIDGET UNTUK KARTU PROGRESS DENGAN GRAFIK LINGKARAN
class ProgressCard extends StatelessWidget {
  final String title;
  final int percentage;
  final String status;
  final Color color;

  const ProgressCard({
    super.key,
    required this.title,
    required this.percentage,
    required this.status,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          SizedBox(
            width: 100,
            height: 100,
            child: CustomPaint(
              painter: CircularProgressPainter(
                percentage: percentage,
                progressColor: color,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$percentage%',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      status,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// PAINTER UNTUK MENGGAMBAR GRAFIK LINGKARAN
class CircularProgressPainter extends CustomPainter {
  final int percentage;
  final Color progressColor;

  CircularProgressPainter({
    required this.percentage,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Lingkaran latar belakang
    Paint backgroundPaint =
        Paint()
          ..color = progressColor.withOpacity(0.2)
          ..strokeWidth = 12
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    // Lingkaran progress
    Paint progressPaint =
        Paint()
          ..color = progressColor
          ..strokeWidth = 12
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, backgroundPaint);

    double sweepAngle = 2 * pi * (percentage / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Mulai dari atas
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
