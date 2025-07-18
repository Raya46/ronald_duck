import 'package:flutter/material.dart';
import 'package:ronald_duck/screens/login_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  try {
    await dotenv.load(fileName: ".env"); 
  } catch (e) {
    throw Exception('Error loading .env file: $e'); 
  }
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Ronald Duck', home: LoginScreen());
  }
}
