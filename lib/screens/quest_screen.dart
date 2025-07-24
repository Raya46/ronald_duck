import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ronald_duck/models/game_schema.dart';
import 'package:ronald_duck/service/game_service.dart';
import 'package:ronald_duck/widgets/option_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Model sederhana untuk merepresentasikan sebuah soal
class Question {
  final String text;
  final List<String> options;
  final String correctAnswer; // 'A', 'B', 'C', or 'D'
  final QuestTopic topic;
  final String hint;
  final String image;
  final String imageIcon;

  Question({
    required this.text,
    required this.options,
    required this.correctAnswer,
    required this.topic,
    required this.hint,
    required this.image,
    required this.imageIcon,
  });
}

class QuestScreen extends StatefulWidget {
  const QuestScreen({super.key});

  @override
  State<QuestScreen> createState() => _QuestScreenState();
}

class _QuestScreenState extends State<QuestScreen> {
  final IsarService isarService = IsarService();
  final supabase = Supabase.instance.client;

  bool _isLoading = true;
  UserProfile? _userProfile;
  String? _selectedOption;
  int _currentQuestionIndex = 0;

  // Daftar soal, bisa diperbanyak atau diambil dari database
  final List<Question> _questions = [
    Question(
      text: 'Ronald punya satu lembar uang Rp5.000. Dia mau beli es krim cokelat seharga Rp3.000. Berapa uang kembalian yang diterima Ronald?',
      options: ['Rp1.000', 'Rp2.000', 'Rp3.000', 'Rp4.000'],
      correctAnswer: 'B',
      topic: QuestTopic.menabung,
      hint: 'Uang Ronald - Harga Es Krim = ???',
      image: 'assets/images/ronald-quest.png',
      imageIcon: 'assets/images/ice-cream.png',
    ),
    Question(
      text: 'Ani ingin membeli mainan baru seharga Rp10.000, tapi dia juga butuh buku tulis untuk sekolah seharga Rp5.000. Mana yang harus Ani beli dulu?',
      options: ['Mainan Baru', 'Buku Tulis', 'Es Krim', 'Tidak keduanya'],
      correctAnswer: 'B',
      topic: QuestTopic.kebutuhan_vs_keinginan,
      hint: 'Mana yang lebih penting untuk belajar di sekolah?',
      image: 'assets/images/ronald-quest.png',
      imageIcon: 'assets/images/book.png', // Ganti dengan ikon yang sesuai
    ),
    Question(
      text: 'Ayah memberi Budi uang jajan Rp20.000 untuk seminggu. Ini disebut apa?',
      options: ['Hadiah', 'Gaji', 'Budget', 'Utang'],
      correctAnswer: 'C',
      topic: QuestTopic.budgeting,
      hint: 'Rencana keuangan untuk periode tertentu disebut...',
      image: 'assets/images/ronald-quest.png',
      imageIcon: 'assets/images/money.png', // Ganti dengan ikon yang sesuai
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final userId = supabase.auth.currentUser?.id;
    if (userId != null) {
      final userProfile = await isarService.getUserProfile(userId);
      if (mounted) {
        setState(() {
          _userProfile = userProfile;
          _isLoading = false;
        });
      }
    } else {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _onOptionSelected(String option) {
    setState(() {
      _selectedOption = option;
    });
  }

  void _checkAnswer() {
    if (_selectedOption == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih jawabanmu dulu!')),
      );
      return;
    }

    final currentQuestion = _questions[_currentQuestionIndex];
    bool isCorrect = _selectedOption == currentQuestion.correctAnswer;

    _updateProgress(isCorrect, currentQuestion.topic);
    _showResultModal(context, isCorrect);
  }

  Future<void> _updateProgress(bool isCorrect, QuestTopic topic) async {
    if (_userProfile == null) return;

    if (isCorrect) {
      setState(() {
        _userProfile!.xp += 20; // Tambah 20 XP jika benar
        _userProfile!.coins += 10; // Tambah 10 Koin jika benar
      });
    }

    // Update Isar
    await isarService.saveUserProfile(_userProfile!);
    await isarService.addQuestHistory(_userProfile!, topic, isCorrect);

    // Update Supabase di latar belakang
    try {
      if (isCorrect) {
        await supabase.from('user_progress').update({
          'xp': _userProfile!.xp,
          'coins': _userProfile!.coins,
        }).eq('user_id', _userProfile!.supabaseUserId);
      }
      await supabase.from('quest_history').insert({
        'user_id': _userProfile!.supabaseUserId,
        'topic': topic.name,
        'is_correct': isCorrect,
      });
    } catch (e) {
      print("Error syncing quest history: $e");
    }
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOption = null; // Reset pilihan
      });
    } else {
      // Semua soal selesai, kembali ke home
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(backgroundColor: Color(0xFFF8ECB8), body: Center(child: CircularProgressIndicator()));
    }

    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      body: Stack(
        children: [
          Container(color: const Color(0xFFF8ECB8)),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: IconButton(
                                icon: const Icon(Icons.refresh),
                                onPressed: () {
                                  setState(() {
                                    _selectedOption = null;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        // --- UI TOP BAR DIPERBARUI ---
                        Row(
                          children: [
                            _buildInfoCard(Icons.local_fire_department, Colors.orange, '${_userProfile?.xp ?? 0}'),
                            const SizedBox(width: 4),
                            _buildInfoCard(Icons.star, Colors.amber, '${_userProfile?.coins ?? 0}'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Stack(
                      alignment: Alignment.topCenter,
                      clipBehavior: Clip.none,
                      children: [
                        Image.asset(
                          currentQuestion.image,
                          width: 200,
                          height: 200,
                        ),
                        Positioned(
                          top: 5,
                          right: 20,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Image.asset(
                              currentQuestion.imageIcon,
                              width: 30,
                              height: 30,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -20,
                          left: 0,
                          right: 0,
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                currentQuestion.text,
                                style: GoogleFonts.nunito(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    ...List.generate(currentQuestion.options.length, (index) {
                      final optionLetter = String.fromCharCode('A'.codeUnitAt(0) + index);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: OptionCard(
                          prefix: optionLetter,
                          text: currentQuestion.options[index],
                          isSelected: _selectedOption == optionLetter,
                          onTap: () => _onOptionSelected(optionLetter),
                        ),
                      );
                    }),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: IconButton(
                            icon: const Icon(Icons.lightbulb_outline),
                            onPressed: () => _showHintModal(context, currentQuestion.hint),
                          ),
                        ),
                        GestureDetector(
                          onTap: _checkAnswer,
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            color: const Color(0xFF78B96A),
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Icon(Icons.check, color: Colors.white, size: 30),
                            ),
                          ),
                        ),
                      ],
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

  // Helper widget untuk info card di atas
  Widget _buildInfoCard(IconData icon, Color color, String text) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 4),
            Text(text, style: GoogleFonts.nunito()),
          ],
        ),
      ),
    );
  }
  
  // Helper widget untuk reward chip di modal
  Widget _buildRewardChip(IconData icon, Color color, String label) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  void _showResultModal(BuildContext context, bool isCorrect) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        bool isLastQuestion = _currentQuestionIndex >= _questions.length - 1;
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF8ECB8),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.only(top: 80, left: 20, right: 20, bottom: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isCorrect ? 'HEBAT!' : 'YAH, SALAH!',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isCorrect ? const Color(0xFF5CB85C) : Colors.red,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      isCorrect ? 'Jawabanmu benar!' : 'Jangan menyerah, coba lagi ya!',
                      style: GoogleFonts.poppins(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    // --- MODAL DIPERBARUI UNTUK MENAMPILKAN KOIN & XP ---
                    if (isCorrect) ...[
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildRewardChip(Icons.local_fire_department, Colors.orange, '+20 XP'),
                          const SizedBox(width: 10),
                          _buildRewardChip(Icons.star, Colors.amber, '+10 Koin'),
                        ],
                      )
                    ],
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Tutup modal
                        if (isCorrect) {
                          _nextQuestion();
                        } else {
                          setState(() => _selectedOption = null);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isCorrect ? const Color(0xFF78B96A) : const Color(0xFFEA8538),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      ),
                      child: Text(
                        isCorrect ? (isLastQuestion ? 'Selesai' : 'Lanjut') : 'Coba Lagi',
                        style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -60,
                child: Image.asset(
                  isCorrect ? 'assets/images/ronald-right.png' : 'assets/images/ronald-wrong.png',
                  width: 150,
                  height: 150,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showHintModal(BuildContext context, String hint) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFF8ECB8), width: 5),
                ),
                padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF8C00),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'HINT',
                        style: GoogleFonts.nunito(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      hint,
                      style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF78B96A),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      ),
                      child: Text(
                        'Mengerti',
                        style: GoogleFonts.nunito(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -30,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8ECB8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.lightbulb, color: Colors.orange, size: 40),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
