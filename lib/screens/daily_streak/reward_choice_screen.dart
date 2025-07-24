import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ronald_duck/models/game_schema.dart';
import 'package:ronald_duck/screens/daily_streak/result_choice_screen.dart';
import 'package:ronald_duck/service/game_service.dart';
import 'dart:math';
import 'package:ronald_duck/widgets/top_spotlight_painter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RewardChoiceScreen extends StatefulWidget {
  final int rewardCoins;

  const RewardChoiceScreen({super.key, required this.rewardCoins});

  @override
  State<RewardChoiceScreen> createState() => _RewardChoiceScreenState();
}

class _RewardChoiceScreenState extends State<RewardChoiceScreen> {
  final IsarService isarService = IsarService();
  final supabase = Supabase.instance.client;
  bool _isLoading = false;

  Future<void> _handleChoice(FinancialChoiceType choiceType) async {
    setState(() => _isLoading = true);

    final userId = supabase.auth.currentUser?.id;
    if (userId == null) {
      // Handle error, user not logged in
      setState(() => _isLoading = false);
      return;
    }

    final userProfile = await isarService.getUserProfile(userId);
    if (userProfile == null) {
      setState(() => _isLoading = false);
      return;
    }

    int coinChange = 0;
    String resultTitle = '';
    String resultIcon = '';
    String resultBonusText = '';

    if (choiceType == FinancialChoiceType.tabung) {
      coinChange = 1;
      userProfile.coins += widget.rewardCoins + coinChange;

      resultTitle = 'Kamu Telah Menabung';
      resultIcon = 'assets/images/piggy-bank.png';
      resultBonusText =
          'Nabungmu berhasil dan kamu dapat +$coinChange koin sebagai bonusnya!';
    } else if (choiceType == FinancialChoiceType.investasi) {
      bool isSuccess = Random().nextBool();
      coinChange = isSuccess ? 5 : -2;
      userProfile.coins += widget.rewardCoins + coinChange;

      resultTitle = isSuccess ? 'Investasimu Untung!' : 'Investasimu Rugi';
      resultIcon = 'assets/images/dice.png';
      resultBonusText =
          isSuccess
              ? 'Selamat! Kamu dapat +$coinChange koin dari investasimu!'
              : 'Yah, kamu rugi $coinChange koin. Coba lagi lain kali!';
    }

    // Simpan ke Isar
    await isarService.saveUserProfile(userProfile);
    await isarService.addFinancialChoice(userProfile, choiceType, coinChange);

    // Update ke Supabase di latar belakang
    _syncToSupabase(userProfile, choiceType, coinChange);

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) => ResultChoiceScreen(
                title: resultTitle,
                iconPath: resultIcon,
                bonusText: resultBonusText,
                rewardCoins: widget.rewardCoins, // Teruskan koin hadiah utama
              ),
        ),
      );
    }
  }

  Future<void> _syncToSupabase(
    UserProfile profile,
    FinancialChoiceType choice,
    int coinChange,
  ) async {
    try {
      // Update total koin
      await supabase
          .from('user_progress')
          .update({'coins': profile.coins})
          .eq('user_id', profile.supabaseUserId);

      // Catat pilihan finansial
      await supabase.from('financial_choices').insert({
        'user_id': profile.supabaseUserId,
        'choice_type': choice.name, // 'tabung' or 'investasi'
        'coin_change': coinChange,
      });
    } catch (e) {
      print("Error syncing choice to Supabase: $e");
      // Data sudah aman di Isar, bisa ditambahkan logika retry nanti
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFF8ECB8),
            child: Opacity(
              opacity: 0.8,
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
                    Image.asset('assets/images/ronald-char.png', width: 150),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 28),
                            padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
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
                            child:
                                _isLoading
                                    ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                    : Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Mau diapakan ${widget.rewardCoins} koin hadiahmu?',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: ChoiceCard(
                                                onPress:
                                                    () => _handleChoice(
                                                      FinancialChoiceType
                                                          .tabung,
                                                    ),
                                                iconPath:
                                                    'assets/images/piggy-bank.png',
                                                title: 'Tabung',
                                                subtitle: '( +1 )',
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: ChoiceCard(
                                                onPress:
                                                    () => _handleChoice(
                                                      FinancialChoiceType
                                                          .investasi,
                                                    ),
                                                iconPath:
                                                    'assets/images/dice.png',
                                                title: 'Investasi',
                                                subtitle: '( +5 atau -2 )',
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFC7A24A),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.info,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  'Investasi bisa untung besar, tapi juga bisa buat rugi',
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ),
                                            ],
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
                              'YUK PILIH!',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
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

class ChoiceCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;
  final VoidCallback onPress;

  const ChoiceCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFFEF8E7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Image.asset(iconPath, width: 48),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: const Color(0xFF6B4F2C),
              ),
            ),
            Text(
              subtitle,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
