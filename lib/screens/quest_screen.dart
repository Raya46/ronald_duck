import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ronald_duck/widgets/option_card.dart';

class QuestScreen extends StatefulWidget {
  const QuestScreen({super.key});

  @override
  State<QuestScreen> createState() => _QuestScreenState();
}

class _QuestScreenState extends State<QuestScreen> {
  String? _selectedOption;
  final String _correctAnswer = 'B';

  void _onOptionSelected(String option) {
    setState(() {
      _selectedOption = option;
    });
  }

  void _checkAnswer() {
    if (_selectedOption == _correctAnswer) {
      _showResultModal(context, true);
    } else {
      _showResultModal(context, false);
    }
  }

  void _showResultModal(BuildContext context, bool isCorrect) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF8ECB8), // Background color of the modal
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFF8ECB8), width: 5),
                ),
                padding: const EdgeInsets.only(top: 80, left: 20, right: 20, bottom: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isCorrect ? 'VICTORY!' : 'OH NO!',
                      style: GoogleFonts.nunito(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isCorrect ? const Color(0xFFFF8C00) : Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      isCorrect ? 'Kamu dapat' : 'Jawabanmu salah',
                      style: GoogleFonts.nunito(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    if (isCorrect) ...[
                      const SizedBox(height: 10),
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star, color: Colors.amber),
                              const SizedBox(width: 8),
                              Text(
                                '+20 Credit',
                                style: GoogleFonts.nunito(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (isCorrect)
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.pop(context); // Go back to home screen
                            },
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              color: const Color(0xFFEA8538),
                              child: const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Icon(
                                  Icons.home,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            if (!isCorrect) {
                              // Optionally reset state for retry
                            }
                          },
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            color: isCorrect ? const Color(0xFFEA8538) : const Color(0xFF78B96A),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              child: Row(
                                children: [
                                  Text(
                                    isCorrect ? 'Lanjut \u2192' : 'Coba Lagi',
                                    style: GoogleFonts.nunito(color: Colors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.close, color: Colors.grey, size: 24),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
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
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.more_horiz),
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(width: 8),
                            Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.refresh),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.monetization_on,
                                  color: Colors.amber,
                                ),
                                const SizedBox(width: 4),
                                Text('100', style: GoogleFonts.nunito()),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Stack(
                      alignment: Alignment.topCenter,
                      clipBehavior: Clip.none,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              'assets/images/ronald-quest.png',
                              width: 200,
                              height: 200,
                            ),
                            const SizedBox(height: 80),
                          ],
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
                              'assets/images/ice-cream.png',
                              width: 30,
                              height: 30,
                            ),
                          ),
                        ),

                        Positioned(
                          bottom: 20,

                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              constraints: const BoxConstraints(maxWidth: 350),
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Ronald punya satu lembar uang Rp5.000. Dia mau beli es krim cokelat seharga Rp3.000. Berapa uang kembalian yang diterima Ronald?',
                                style: GoogleFonts.nunito(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        OptionCard(
                          prefix: 'A',
                          text: 'Rp1.000',
                          onTap: () => _onOptionSelected('A'),
                          isCorrect: false,
                        ),
                        const SizedBox(height: 10),
                        OptionCard(
                          prefix: 'B',
                          text: 'Rp2.000',
                          onTap: () => _onOptionSelected('B'),
                          isCorrect: true,
                        ),
                        const SizedBox(height: 10),
                        OptionCard(
                          prefix: 'C',
                          text: 'Rp3.000',
                          onTap: () => _onOptionSelected('C'),
                          isCorrect: false,
                        ),
                        const SizedBox(height: 10),
                        OptionCard(
                          prefix: 'D',
                          text: 'Rp4.000',
                          onTap: () => _onOptionSelected('D'),
                          isCorrect: false,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    _showHintModal(context);
                                  },
                                  child: Image.asset(
                                    'assets/images/bulb.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -5,
                                right: -5,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.info_outline,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: _checkAnswer,
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            color: const Color(0xFF78B96A),
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 30,
                              ),
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

  void _showHintModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
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
                padding: const EdgeInsets.only(
                  top: 60,
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
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
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF78B96A),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Uang Ronald - Harga Es Krim = ???',
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Kwek! Untuk menemukan jawabannya, coba kurangi uang yang Ronald punya dengan harga es krimnya. Berapa ya hasilnya?',
                      style: GoogleFonts.nunito(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF78B96A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                      ),
                      child: Text(
                        'Close',
                        style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 16,
                        ),
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
                  child: const Icon(
                    Icons.lightbulb,
                    color: Colors.orange,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
