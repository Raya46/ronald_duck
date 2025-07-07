import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class VoiceScreen extends StatefulWidget {
  const VoiceScreen({super.key});

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen>
    with SingleTickerProviderStateMixin {
  bool _isRecording = false;
  late AnimationController _animationController;
  final SpeechToText _speechToText = SpeechToText();
  late final GenerativeModel _model;
  final AudioPlayer _audioPlayer = AudioPlayer();
  String _lastWords = '';
  String _geminiResponse = '';
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
      final String apiKey = dotenv.env['GEMINI_API_KEY'] ?? 'default_url';
    _model = GenerativeModel(model: 'gemini-2.0', apiKey: apiKey);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
    _initSpeech();
    _initTts();
  }

  void _initTts() async {
    await _flutterTts.setLanguage("id-ID");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setSpeechRate(0.5);
  }

  void _initSpeech() async {
    await _speechToText.initialize(
      onStatus: (status) {
        print('Speech status: $status');
        if (status == 'listening') {
          setState(() {
            _isRecording = true;
          });
        } else if (status == 'notListening') {
          setState(() {
            _isRecording = false;
          });
        }
      },
      onError: (errorNotification) {
        setState(() {
          _isRecording = false;
        });
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _speechToText.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _toggleRecording() async {
    if (_isRecording) {
      _speechToText.stop();
    } else {
      _lastWords = '';
      _geminiResponse = '';
      bool available = await _speechToText.listen(
        onResult: (result) {
          setState(() {
            _lastWords = result.recognizedWords;
          });
          if (result.finalResult) {
            _sendToGemini(_lastWords);
          }
        },
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 3),
        localeId: 'en_US',
      );
      if (!available) {
        print('The user has denied the use of speech recognition.');
        setState(() {
          _isRecording = false;
        });
      }
    }
  }

  void _sendToGemini(String text) async {
    setState(() {
      _geminiResponse = 'AI sedang berpikir...';
    });
    try {
      final content = [Content.text(text)];

      final response = await _model.generateContent(content);

      setState(() {
        _geminiResponse = response.text ?? 'Tidak ada respons dari AI.';
      });
      _speak(_geminiResponse);
    } catch (e) {
      setState(() {
        _geminiResponse = 'Error: $e';
      });
      print('Error mengirim ke Gemini: $e');
    }
  }

  void _speak(String text) async {
    print('AI Speaking: $text');
    if (text.isNotEmpty) {
      await _flutterTts.speak(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFFFAEC5F).withOpacity(1.0),
                  const Color(0xFFFAEC5F).withOpacity(0.0),
                ],
                stops: const [0.0, 0.5],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: ArcClipper(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                color: const Color(0xFF78B96A),
              ),
            ),
          ),

          ...List.generate(
            20,
            (index) => Positioned(
              top:
                  Random().nextDouble() *
                  MediaQuery.of(context).size.height *
                  0.6,
              left: Random().nextDouble() * MediaQuery.of(context).size.width,
              child: FadeTransition(
                opacity: _animationController,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
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
                                Icons.local_fire_department,
                                color: Colors.orange,
                              ),
                              const SizedBox(width: 4),
                              Text('100 XP', style: GoogleFonts.nunito()),
                            ],
                          ),
                        ),
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
                              const Icon(Icons.star, color: Colors.amber),
                              const SizedBox(width: 4),
                              Text('100', style: GoogleFonts.nunito()),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.settings),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/ronald-wink.png',
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(height: 50),

                      if (_isRecording)
                        SizedBox(
                          height: 50,
                          child: CustomPaint(
                            painter: SoundWavePainter(
                              animation: _animationController,
                            ),
                            child: Container(),
                          ),
                        ),
                      const SizedBox(height: 50),
                      GestureDetector(
                        onTap: _toggleRecording,
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.asset(
                              _isRecording
                                  ? 'assets/images/stop.png'
                                  : 'assets/images/voice.png',
                              width: 60,
                              height: 60,
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
        ],
      ),
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.2);
    path.quadraticBezierTo(size.width / 2, 0, size.width, size.height * 0.2);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class SoundWavePainter extends CustomPainter {
  final Animation<double> animation;

  SoundWavePainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white
          ..strokeWidth = 3.0
          ..strokeCap = StrokeCap.round;

    final double barWidth = size.width / 20;
    for (int i = 0; i < 20; i++) {
      final double x = i * barWidth + barWidth / 2;
      final double normalizedValue =
          sin((i / 20.0) * pi * 2 + animation.value * pi * 2).abs();
      final double barHeight = size.height * 0.8 * normalizedValue + 5;

      canvas.drawLine(
        Offset(x, size.height / 2 - barHeight / 2),
        Offset(x, size.height / 2 + barHeight / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
