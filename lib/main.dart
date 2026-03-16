import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const BotSenseApp());
}

class BotSenseApp extends StatelessWidget {
  const BotSenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}