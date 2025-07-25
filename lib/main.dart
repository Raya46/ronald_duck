import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ronald_duck/screens/splash_screen.dart';
import 'package:ronald_duck/service/game_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sizer/sizer.dart';

final isarService = IsarService();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );

  await isarService.db;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Ronald Duck',
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
