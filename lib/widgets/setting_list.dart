import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ronald_duck/screens/login_screen.dart';
import 'package:ronald_duck/screens/setting/about_app_screen.dart';
import 'package:ronald_duck/screens/setting/contact_screen.dart';
import 'package:ronald_duck/screens/setting/insert_password_screen.dart';
import 'package:ronald_duck/screens/setting/play_time_screen.dart';
import 'package:ronald_duck/screens/setting/theme_music_screen.dart';
import 'package:ronald_duck/service/game_service.dart';
import 'package:ronald_duck/widgets/setting_placeholder.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final IsarService isarService = IsarService();
  bool _isLoading = false;

  Future<void> _signOut() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 1. Logout dari Supabase
      await Supabase.instance.client.auth.signOut();

      // 2. Hapus semua data dari database lokal Isar
      final isar = await isarService.db;
      await isar.writeTxn(() async {
        await isar.clear();
      });

      // 3. Navigasi ke LoginScreen dan hapus semua halaman sebelumnya
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal untuk logout: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
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
              opacity: 0.3,
              child: Image.asset(
                'assets/images/bg-pattern.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: CustomSettingsCard(
                title: "Pengaturan",
                child: Column(
                  children: [
                    SettingList(
                      icon: Icons.timer_outlined,
                      title: "Atur Waktu Bermain",
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PlayTimerScreen(),
                          ),
                        );
                      },
                    ),
                    SettingList(
                      icon: Icons.music_note_outlined,
                      title: "Tema & Musik",
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ThemeMusicScreen(),
                          ),
                        );
                      },
                    ),
                    SettingList(
                      icon: Icons.lock_outline,
                      title: "Kontrol Orang Tua",
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const InsertPassword(),
                          ),
                        );
                      },
                    ),
                    SettingList(
                      icon: Icons.info_outline,
                      title: "Tentang Aplikasi",
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AboutAppScreen(),
                          ),
                        );
                      },
                    ),
                    SettingList(
                      icon: Icons.headset_mic_outlined,
                      title: "Hubungi Kami",
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ContactScreen(),
                          ),
                        );
                      },
                    ),
                    SettingList(
                      icon: Icons.logout_outlined,
                      title: "Logout",
                      isLoading: _isLoading,
                      onPress: _isLoading ? null : _signOut,
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

class SettingList extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback? onPress;
  final bool isLoading; // Tambahkan parameter isLoading

  const SettingList({
    super.key,
    required this.title,
    this.icon,
    this.onPress,
    this.isLoading = false, // Default value adalah false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: InkWell(
        onTap: isLoading ? null : onPress, // Nonaktifkan tap saat loading
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: const Color(0xFFFEFAF1),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 4),
                blurRadius: 10,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 24.0,
                    color: const Color(0xFFF39237),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF6B4F2C),
                    ),
                  ),
                ],
              ),
              // Tampilkan loading indicator atau ikon panah
              if (isLoading)
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Color(0xFF6B4F2C),
                  ),
                )
              else
                const Icon(
                  Icons.chevron_right,
                  size: 24.0,
                  color: Color(0xFF6B4F2C),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
