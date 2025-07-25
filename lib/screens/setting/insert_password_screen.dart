import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ronald_duck/models/game_schema.dart';
import 'package:ronald_duck/screens/parent/parent_dashboard_screen.dart';
import 'package:ronald_duck/service/game_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InsertPassword extends StatefulWidget {
  const InsertPassword({super.key});

  @override
  State<InsertPassword> createState() => _InsertPasswordState();
}

class _InsertPasswordState extends State<InsertPassword> {
  final _passwordController = TextEditingController();
  final _isarService = IsarService();
  bool _isLoading = false;

  Future<void> _validateParentPassword() async {
    if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password tidak boleh kosong'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tidak ada pengguna yang aktif.'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() => _isLoading = false);
      return;
    }

    final UserProfile? userProfile = await _isarService.getUserProfile(userId);

    if (userProfile != null) {
      if (userProfile.parentPassword == _passwordController.text.trim()) {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ParentDashboardScreen(),
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password orang tua salah!'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profil pengguna tidak ditemukan.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBorderColor = Color(0xFFE4B34B);
    const Color secondaryBorderColor = Color(0xFFF3D06E);
    const Color contentBgColor = Color(0xFFF9E08B);
    const Color headerColor = Color(0xFFF39237);
    const Color fieldColor = Color(0xFFFEF8E7);
    const Color textDarkColor = Color(0xFF6B4F2C);

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
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryBorderColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0, 10),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: secondaryBorderColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(24, 100, 24, 32),
                        decoration: BoxDecoration(
                          color: contentBgColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 20),
                            TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Tulis password',
                                hintStyle: GoogleFonts.poppins(
                                  color: textDarkColor.withOpacity(0.7),
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: textDarkColor,
                                ),
                                filled: true,
                                fillColor: fieldColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed:
                                    _isLoading ? null : _validateParentPassword,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: fieldColor,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 2,
                                ),
                                child:
                                    _isLoading
                                        ? const SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: CircularProgressIndicator(
                                            color: textDarkColor,
                                            strokeWidth: 3,
                                          ),
                                        )
                                        : Text(
                                          'Masuk',
                                          style: GoogleFonts.poppins(
                                            color: textDarkColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                          ),
                                        ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        child: CustomPaint(
                          painter: ScallopedHeaderPainter(color: headerColor),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Text(
                                'MASUKKAN PASSWORD',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScallopedHeaderPainter extends CustomPainter {
  final Color color;
  ScallopedHeaderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    var path = Path();

    const scallopRadius = 18.0;
    final scallopCount = (size.width / (scallopRadius * 2)).floor();
    final totalScallopWidth = scallopCount * (scallopRadius * 2);
    final startX = (size.width - totalScallopWidth) / 2;

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - scallopRadius);

    for (int i = 0; i < scallopCount; i++) {
      path.arcToPoint(
        Offset(
          startX + totalScallopWidth - ((i + 1) * scallopRadius * 2),
          size.height - scallopRadius,
        ),
        radius: const Radius.circular(scallopRadius),
        clockwise: false,
      );
    }

    path.lineTo(0, size.height - scallopRadius);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant ScallopedHeaderPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
