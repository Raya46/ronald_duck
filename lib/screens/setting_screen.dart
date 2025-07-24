import 'package:flutter/material.dart';
import 'package:ronald_duck/screens/home_screen.dart';
import 'package:ronald_duck/screens/login_screen.dart';
import 'package:ronald_duck/screens/setting/about_app_screen.dart';
import 'package:ronald_duck/screens/setting/contact_screen.dart';
import 'package:ronald_duck/screens/setting/insert_password_screen.dart';
import 'package:ronald_duck/screens/setting/play_time_screen.dart';
import 'package:ronald_duck/screens/setting/theme_music_screen.dart';
import 'package:ronald_duck/service/game_service.dart';
import 'package:ronald_duck/widgets/setting_list.dart';
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
                    SettingList(
                      icon: Icons.home_outlined,
                      title: "Back to home",
                      onPress: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
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
