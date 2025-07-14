import 'package:flutter/material.dart';

class ThemeMusicScreen extends StatefulWidget {
  const ThemeMusicScreen({super.key});

  @override
  State<ThemeMusicScreen> createState() => _ThemeMusicScreenState();
}

class _ThemeMusicScreenState extends State<ThemeMusicScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [Text("theme music")]));
  }
}
