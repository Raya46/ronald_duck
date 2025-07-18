import 'package:flutter/material.dart';
import 'package:ronald_duck/screens/login_screen.dart';
import 'package:ronald_duck/screens/setting/about_app_screen.dart';
import 'package:ronald_duck/screens/setting/contact_screen.dart';
import 'package:ronald_duck/screens/setting/insert_password_screen.dart';
import 'package:ronald_duck/screens/setting/play_time_screen.dart';
import 'package:ronald_duck/screens/setting/theme_music_screen.dart';
import 'package:ronald_duck/widgets/setting_list.dart';
import 'package:ronald_duck/widgets/setting_placeholder.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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
                      title: "Atur Waktu Bermain",
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlayTimerScreen(),
                          ),
                        );
                      },
                    ),
                    SettingList(
                      title: "Tema & Musik",
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ThemeMusicScreen(),
                          ),
                        );
                      },
                    ),
                    SettingList(
                      title: "Kontrol Orang Tua",
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InsertPassword(),
                          ),
                        );
                      },
                    ),
                    SettingList(
                      title: "Tentang Aplikasi",
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AboutAppScreen(),
                          ),
                        );
                      },
                    ),
                    SettingList(
                      title: "Hubungi Kami",
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContactScreen(),
                          ),
                        );
                      },
                    ),
                    SettingList(
                      title: "Logout",
                      onPress: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
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
