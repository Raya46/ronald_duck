import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  String _lastWords = '';
  String _apiResponse = '';
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
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
        if (status == 'listening') {
          if (!_isRecording) setState(() => _isRecording = true);
        } else if (status == 'notListening' || status == 'done') {
          if (_isRecording) setState(() => _isRecording = false);
        }
      },
      onError: (errorNotification) {
        setState(() => _isRecording = false);
        print('Speech recognition error: $errorNotification');
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _speechToText.stop();
    _flutterTts.stop();
    super.dispose();
  }

  void _toggleRecording() async {
    if (_isRecording) {
      _speechToText.stop();
      setState(() => _isRecording = false);
    } else {
      var status = await Permission.microphone.request();

      if (status.isGranted) {
        _lastWords = '';
        _apiResponse = ''; // Reset respons
        _speechToText.listen(
          onResult: (result) {
            setState(() => _lastWords = result.recognizedWords);
            if (result.finalResult) {
              _sendToOpenRouter(_lastWords); // Panggil fungsi API
            }
          },
          listenFor: const Duration(seconds: 30),
          pauseFor: const Duration(seconds: 3),
          localeId: 'id_ID',
        );
        setState(() => _isRecording = true);
      } else {
        print('Izin mikrofon ditolak oleh pengguna.');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Izin mikrofon diperlukan untuk menggunakan fitur ini.',
              ),
            ),
          );
        }
      }
    }
  }

  void _sendToOpenRouter(String text) async {
    if (text.isEmpty) return;

    setState(() {
      _apiResponse = 'AI sedang berpikir...';
    });

    final apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';
    if (apiKey.isEmpty) {
      print('API Key OpenRouter tidak ditemukan di .env');
      setState(() {
        _apiResponse = 'API Key tidak ditemukan.';
      });
      return;
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    final body = jsonEncode({
      "model": "openai/gpt-4o-mini",
      "messages": [
        {
          "role": "system",
          "content":
              "Kamu adalah Ronald bebek, pakar finansial yang ramah, ceria, dan membantu untuk anak. Selalu jawab dalam bahasa Indonesia. Tugas kamu adalah mengajari anak anak untuk paham finansial, dan ingat kamu adalah seekor bebek jadi jawab dengan Wek! untuk awal dan akhir dari respon",
        },
        {"role": "user", "content": text},
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
        final responseText =
            decodedResponse['choices'][0]['message']['content'] ??
            'Tidak ada respons dari AI.';

        setState(() {
          _apiResponse = responseText;
        });
        _speak(_apiResponse);
      } else {
        print('Error dari OpenRouter: ${response.statusCode}');
        print('Body Error: ${response.body}');
        setState(() {
          _apiResponse = 'Gagal menghubungi AI. Kode: ${response.statusCode}';
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _apiResponse = 'Terjadi kesalahan jaringan. Coba lagi.';
      });
    }
  }

  void _speak(String text) async {
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
                        width: 400,
                        height: 400,
                      ),
                      const SizedBox(height: 20),
                      if (_isRecording)
                        SizedBox(
                          height: 50,
                          child: CustomPaint(
                            painter: SoundWavePainter(
                              animation: _animationController,
                            ),
                            child: Container(),
                          ),
                        )
                      else
                        const SizedBox(
                          height: 50,
                        ), // Placeholder agar layout stabil
                      const SizedBox(height: 20),
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
