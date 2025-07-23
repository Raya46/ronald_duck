import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async'; // Import untuk Timer

class VoiceScreen extends StatefulWidget {
  const VoiceScreen({super.key});

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen>
    with SingleTickerProviderStateMixin {
  bool _isRecording = false;
  bool _isThinking = false;
  bool _isSpeaking = false;
  late AnimationController _animationController;
  final SpeechToText _speechToText = SpeechToText();
  String _lastWords = '';
  String _apiResponse = '';
  String _subtitleText = ''; // State untuk teks subtitel
  final AudioPlayer _audioPlayer = AudioPlayer();
  Timer? _subtitleTimer; // Timer untuk subtitel

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
    _initSpeech();
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
    _subtitleTimer?.cancel(); // Batalkan timer saat dispose
    _audioPlayer.dispose();
    super.dispose();
  }

  void _toggleRecording() async {
    if (_isRecording || _isThinking || _isSpeaking) return;

    if (await _speechToText.isListening) {
      _speechToText.stop();
      setState(() => _isRecording = false);
    } else {
      var status = await Permission.microphone.request();

      if (status.isGranted) {
        setState(() {
          _lastWords = '';
          _apiResponse = '';
          _subtitleText = ''; // Reset subtitel
        });
        _speechToText.listen(
          onResult: (result) {
            setState(() => _lastWords = result.recognizedWords);
            if (result.finalResult) {
              _sendToOpenRouter(_lastWords);
            }
          },
          listenFor: const Duration(seconds: 30),
          pauseFor: const Duration(seconds: 5),
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
      _isThinking = true;
      _subtitleText = 'Ronald sedang berpikir...';
    });

    final apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';
    if (apiKey.isEmpty) {
      print('API Key OpenRouter tidak ditemukan di .env');
      setState(() {
        _isThinking = false;
        _subtitleText = 'API Key tidak ditemukan.';
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
          _subtitleText = '';
        });
        _speakWithElevenLabsAPI(responseText);
      } else {
        final errorText = 'Gagal menghubungi AI. Kode: ${response.statusCode}';
        print('Error dari OpenRouter: ${response.statusCode}');
        print('Body Error: ${response.body}');
        setState(() {
          _isThinking = false;
          _subtitleText = errorText;
        });
      }
    } catch (e) {
      final errorText = 'Terjadi kesalahan jaringan. Coba lagi.';
      print('Error: $e');
      setState(() {
        _isThinking = false;
        _subtitleText = errorText;
      });
    }
  }

  void _speakWithElevenLabsAPI(String text) async {
    if (text.isEmpty) {
      setState(() => _isThinking = false);
      return;
    }
    
    // Tetap dalam state berpikir saat audio di-load
    setState(() {
      _subtitleText = 'Ronald sedang berpikir...';
    });

    final apiKey = dotenv.env['ELEVENLABS_API_KEY'];
    const voiceId = "iWydkXKoiVtvdn4vLKp9";
    final url = "https://api.elevenlabs.io/v1/text-to-speech/$voiceId";

    if (apiKey == null || apiKey.isEmpty) {
      print("ElevenLabs API key not found");
      setState(() {
        _isThinking = false;
        _subtitleText = "ElevenLabs API key not found";
      });
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'xi-api-key': apiKey,
        },
        body: jsonEncode({
          "text": text,
          "model_id": "eleven_multilingual_v2",
        }),
      );

      if (response.statusCode == 200) {
        final directory = await getTemporaryDirectory();
        final filePath = '${directory.path}/temp_audio.mp3';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        await _audioPlayer.stop();
        
        setState(() {
          _isThinking = false;
          _isSpeaking = true; // Mulai berbicara
        });
        
        await _audioPlayer.play(DeviceFileSource(filePath));
        _startSubtitleTimer(text);

      } else {
        print("Error from ElevenLabs API: ${response.statusCode}");
        print("Response Body: ${response.body}");
        setState(() {
          _isThinking = false;
          _subtitleText = "Gagal memuat audio.";
        });
      }
    } catch (e) {
      print("Error calling ElevenLabs API: $e");
      setState(() {
        _isThinking = false;
        _subtitleText = "Gagal memuat audio.";
      });
    }
  }

  void _startSubtitleTimer(String fullText) async {
    _subtitleTimer?.cancel();
    
    await Future.delayed(const Duration(milliseconds: 200));
    final audioDuration = await _audioPlayer.getDuration();
    
    final words = fullText.split(' ');
    if (words.isEmpty || audioDuration == null || audioDuration.inMilliseconds == 0) {
      setState(() => _subtitleText = fullText);
      return;
    }

    const chunkSize = 3;
    final double delayPerChunk = (audioDuration.inMilliseconds / words.length) * chunkSize;
    int wordIndex = 0;

    _subtitleTimer = Timer.periodic(Duration(milliseconds: delayPerChunk.round()), (timer) {
      if (wordIndex < words.length) {
        if (mounted) {
          final end = (wordIndex + chunkSize > words.length) ? words.length : wordIndex + chunkSize;
          setState(() {
            _subtitleText = words.sublist(wordIndex, end).join(' ');
          });
        }
        wordIndex += chunkSize;
      } else {
        timer.cancel();
      }
    });

    _audioPlayer.onPlayerComplete.first.then((_) {
      _subtitleTimer?.cancel();
      if(mounted) {
        setState(() {
          _isSpeaking = false;
          _subtitleText = ''; // Kosongkan subtitel setelah selesai
        });
      }
    });
  }

  String _getCurrentRonaldImage() {
    if (_isThinking) {
      return 'assets/images/ronald-wrong.png';
    }
    if (_isSpeaking) {
      return 'assets/images/ronald-adult.png';
    }
    return 'assets/images/ronald-wink.png';
  }

  @override
  Widget build(BuildContext context) {
    String displayText;
    if (_isRecording) {
      displayText = 'Mendengarkan...';
    } else if (_isThinking) {
      displayText = 'Ronald sedang berpikir...';
    } else if (_subtitleText.isNotEmpty) {
      displayText = _subtitleText;
    } else {
      displayText = 'Tekan tombol untuk bicara';
    }

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
                      // ... (Card XP dan Star lainnya)
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        _getCurrentRonaldImage(),
                        width: 300,
                        height: 300,
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          displayText,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (_isRecording || _isThinking)
                        SizedBox(
                          height: 50,
                          child: _isThinking
                              ? const Center(child: CircularProgressIndicator(color: Colors.white))
                              : CustomPaint(
                                  painter: SoundWavePainter(
                                    animation: _animationController,
                                  ),
                                  child: Container(),
                                ),
                        )
                      else
                        const SizedBox(
                          height: 50,
                        ),
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
  @override
  bool shouldReclip(covariant CustomPainter oldDelegate) {
    return true;
  }
}
