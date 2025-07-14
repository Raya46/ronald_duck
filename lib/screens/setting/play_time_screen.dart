import 'package:flutter/material.dart';

class PlayTimerScreen extends StatefulWidget {
  const PlayTimerScreen({super.key});

  @override
  State<PlayTimerScreen> createState() => _PlayTimerScreenState();
}

class _PlayTimerScreenState extends State<PlayTimerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [Text("play time")]));
  }
}
