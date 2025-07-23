import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ronald_duck/screens/daily_streak/reward_choice_screen.dart';
import 'package:ronald_duck/widgets/top_spotlight_painter.dart';

class DailyStreakScreen extends StatefulWidget {
  const DailyStreakScreen({super.key});

  @override
  State<DailyStreakScreen> createState() => _DailyStreakScreenState();
}

class _DailyStreakScreenState extends State<DailyStreakScreen> {
  final List<Map<String, dynamic>> streakData = [
    {'day': 'DAY 1', 'points': 10},
    {'day': 'DAY 2', 'points': 30},
    {'day': 'DAY 3', 'points': 50},
    {'day': 'DAY 4', 'points': 70},
    {'day': 'DAY 5', 'points': 90},
    {'day': 'DAY 6', 'points': 100},
    {'day': 'DAY 7', 'points': 150},
  ];

  int _claimedDays = 0;

  void _claimReward() {
    setState(() {
      if (_claimedDays < 7) {
        _claimedDays++;
      }
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RewardChoiceScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFF8ECB8),
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/images/bg-pattern.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          CustomPaint(painter: TopSpotlightPainter(), child: Container()),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/fire-streak.png', width: 150),
                    const SizedBox(height: 16),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 28),
                            padding: const EdgeInsets.fromLTRB(16, 50, 16, 24),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDFBC5F),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  offset: const Offset(0, 8),
                                  blurRadius: 15,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        childAspectRatio: 0.85,
                                      ),
                                  itemCount: streakData.length,
                                  itemBuilder: (context, index) {
                                    return DayStreakCard(
                                      day: streakData[index]['day'],
                                      points: streakData[index]['points'],
                                      isClaimed: index < _claimedDays,
                                    );
                                  },
                                ),
                                const SizedBox(height: 24),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: _claimReward,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFFEF8E7),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      elevation: 2,
                                    ),
                                    child: Text(
                                      'Ambil Hadiah',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF6B4F2C),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                            ),
                            child: Text(
                              'DAILY STREAK!',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),

                          Positioned(
                            top: -10,
                            right: -10,
                            child: InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              child: const CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.close,
                                  color: Color(0xFFF39237),
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ],
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

class DayStreakCard extends StatelessWidget {
  final String day;
  final int points;
  final bool isClaimed;

  const DayStreakCard({
    super.key,
    required this.day,
    required this.points,
    this.isClaimed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isClaimed ? const Color(0xFF4A4A4A) : const Color(0xFFFEF8E7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color:
                  isClaimed
                      ? Colors.black.withOpacity(0.2)
                      : const Color(0xFFF39237),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              day,
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          isClaimed
              ? const CircleAvatar(
                radius: 14,
                backgroundColor: Color(0xFF5CB85C),
                child: Icon(Icons.check, color: Colors.white, size: 18),
              )
              : const Icon(Icons.star, color: Colors.amber, size: 28),
          Text(
            '+$points',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isClaimed ? Colors.white70 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
