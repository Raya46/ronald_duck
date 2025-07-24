// File: lib/screens/splash_screen.dart

import 'package:flutter/material.dart';
import 'package:ronald_duck/screens/home_screen.dart'; // Ganti dengan path home screen Anda
import 'package:ronald_duck/screens/login_screen.dart'; // Ganti dengan path login screen Anda
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Gunakan _redirect untuk memeriksa sesi saat halaman pertama kali dimuat
    _redirect();
  }

  Future<void> _redirect() async {
    // Tunggu sebentar untuk memastikan Supabase sudah siap
    await Future.delayed(Duration.zero);

    // Periksa apakah widget masih ada di tree (best practice)
    if (!mounted) return;

    final session = Supabase.instance.client.auth.currentSession;

    if (session != null) {
      // Jika ada sesi (pengguna sudah login), arahkan ke HomeScreen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // Jika tidak ada sesi, arahkan ke LoginScreen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Tampilkan UI loading sederhana selama proses pengecekan
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}