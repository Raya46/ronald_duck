import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:ronald_duck/models/game_schema.dart';
import 'package:ronald_duck/screens/parent/parent_setting_screen.dart';
import 'package:ronald_duck/service/game_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:math';

class ParentDashboardScreen extends StatefulWidget {
  const ParentDashboardScreen({super.key});

  @override
  State<ParentDashboardScreen> createState() => _ParentDashboardScreenState();
}

class _ParentDashboardScreenState extends State<ParentDashboardScreen> {
  final IsarService isarService = IsarService();
  final supabase = Supabase.instance.client;

  bool _isLoading = true;
  String _insightText = 'Memuat insight';

  UserProfile? _userProfile;
  List<QuestHistory> _questHistory = [];

  double _waktuBelajarJam = 0.0;
  int _gameSelesaiBenar = 0;

  int _menabungPercent = 0;
  int _kebutuhanVsKeinginanPercent = 0;
  int _budgetingPercent = 0;
  int _investasiRisikoPercent = 0;

  @override
  void initState() {
    super.initState();
    _fetchAndProcessData();
  }

  Future<void> _fetchAndProcessData() async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) {
      setState(() => _isLoading = false);
      return;
    }

    _userProfile = await isarService.getUserProfile(userId);
    if (_userProfile != null) {
      _questHistory = await _userProfile!.questHistory.filter().findAll();
      _calculateStatistics();
      setState(() => _isLoading = false);
    }

    try {
      final profileFuture = isarService.getUserProfile(userId);
      final historyFuture = supabase
          .from('quest_history')
          .select()
          .eq('user_id', userId)
          .then((data) => data);

      final results = await Future.wait<dynamic>([
        profileFuture,
        historyFuture,
      ]);

      _userProfile = results[0] as UserProfile?;
      final historyResponse = results[1] as List<dynamic>;

      _questHistory =
          historyResponse
              .map(
                (e) => QuestHistory(
                  topic: QuestTopic.values.byName(e['topic']),
                  isCorrect: e['is_correct'],
                  answeredAt: DateTime.parse(e['answered_at']),
                ),
              )
              .toList();

      if (_userProfile != null) {
        _calculateStatistics();
        _generateInsight();
        setState(() {});
      }
    } catch (e) {
      print("Error syncing with Supabase: $e");
      if (mounted) {
        setState(() {
          _insightText = "Gagal memuat insight.";
        });
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _calculateStatistics() {
    _gameSelesaiBenar = _questHistory.where((q) => q.isCorrect).length;

    _menabungPercent = _calculateTopicPercentage(QuestTopic.menabung);
    _kebutuhanVsKeinginanPercent = _calculateTopicPercentage(
      QuestTopic.kebutuhan_vs_keinginan,
    );
    _budgetingPercent = _calculateTopicPercentage(QuestTopic.budgeting);
    _investasiRisikoPercent = _calculateTopicPercentage(
      QuestTopic.investasi_risiko,
    );
  }

  int _calculateTopicPercentage(QuestTopic topic) {
    final topicQuests = _questHistory.where((q) => q.topic == topic).toList();
    if (topicQuests.isEmpty) return 0;
    final correctAnswers = topicQuests.where((q) => q.isCorrect).length;
    return ((correctAnswers / topicQuests.length) * 100).round();
  }

  String _getStatus(int percentage) {
    if (percentage >= 90) return 'Sangat Baik';
    if (percentage >= 75) return 'Baik';
    if (percentage >= 50) return 'Cukup';
    return 'Perlu Belajar';
  }

  Future<void> _generateInsight() async {
    final apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';
    if (apiKey.isEmpty) {
      setState(() => _insightText = 'API Key AI tidak ditemukan.');
      return;
    }

    String prompt = """
    Analisis data belajar anak bernama ${_userProfile?.name ?? 'Anak'} dan berikan insight singkat (maksimal 3 kalimat) untuk orang tuanya dalam bahasa Indonesia.
    Gaya bahasa harus positif dan memberi saran.
    
    Data:
    - Konsep Menabung: $_menabungPercent%
    - Kebutuhan vs. Keinginan: $_kebutuhanVsKeinginanPercent%
    - Dasar Budgeting: $_budgetingPercent%
    - Investasi & Risiko: $_investasiRisikoPercent%
    
    Contoh output: "${_userProfile?.name ?? 'Anak'} menunjukkan pemahaman yang baik tentang menabung. Ini adalah fondasi yang bagus! Ajak ia bicara tentang manfaat mengambil risiko kecil untuk meningkatkan pemahaman investasinya."
    """;

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
    final body = jsonEncode({
      "model": "openai/gpt-4o-mini",
      "messages": [
        {"role": "user", "content": prompt},
      ],
    });

    try {
      final response = await http.post(
        Uri.parse("https://openrouter.ai/api/v1/chat/completions"),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          _insightText = decodedResponse['choices'][0]['message']['content'];
        });
      } else {
        setState(() => _insightText = 'Gagal menghasilkan insight.');
      }
    } catch (e) {
      setState(() => _insightText = 'Gagal terhubung ke layanan AI.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8ECB8),
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
        actions: [
          IconButton(
            icon: Icon(Icons.settings_outlined),
            tooltip: 'Pengaturan Orang Tua',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ParentSettingScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InfoCard(
                            icon: Icons.access_time_filled,
                            iconColor: Colors.orange,
                            title: 'Waktu Belajar',
                            value: '${_waktuBelajarJam.toStringAsFixed(1)} Jam',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: InfoCard(
                            icon: Icons.extension,
                            iconColor: Colors.blueAccent,
                            title: 'Game Selesai',
                            value: '$_gameSelesaiBenar Benar',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: InfoCard(
                            icon: Icons.local_fire_department,
                            iconColor: Colors.redAccent,
                            title: 'Streak',
                            value:
                                '${_userProfile?.currentStreakDay ?? 0} Hari',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.9,
                      children: [
                        ProgressCard(
                          title: 'Konsep Menabung',
                          percentage: _menabungPercent,
                          status: _getStatus(_menabungPercent),
                          color: const Color(0xFF5CB85C),
                        ),
                        ProgressCard(
                          title: 'Kebutuhan vs. Keinginan',
                          percentage: _kebutuhanVsKeinginanPercent,
                          status: _getStatus(_kebutuhanVsKeinginanPercent),
                          color: const Color(0xFFF0AD4E),
                        ),
                        ProgressCard(
                          title: 'Dasar Budgeting',
                          percentage: _budgetingPercent,
                          status: _getStatus(_budgetingPercent),
                          color: const Color(0xFFFFD700),
                        ),
                        ProgressCard(
                          title: 'Investasi & Risiko',
                          percentage: _investasiRisikoPercent,
                          status: _getStatus(_investasiRisikoPercent),
                          color: const Color(0xFF5BC0DE),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
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
                          const Icon(
                            Icons.lightbulb,
                            color: Colors.amber,
                            size: 20,
                          ),
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
                                  _insightText,
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

class CircularProgressPainter extends CustomPainter {
  final int percentage;
  final Color progressColor;

  CircularProgressPainter({
    required this.percentage,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint =
        Paint()
          ..color = progressColor.withOpacity(0.2)
          ..strokeWidth = 12
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

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
      -pi / 2,
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
