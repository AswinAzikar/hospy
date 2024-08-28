import 'package:flutter/material.dart';
import 'package:hospy/landing_screen/landing_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Define the default font family
        fontFamily: 'Lexend',

        // Define different text styles
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w900, // Black
            fontSize: 96,
            letterSpacing: -1.5,
          ),
          displayMedium: TextStyle(
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w800, // ExtraBold
            fontSize: 60,
            letterSpacing: -0.5,
          ),
          displaySmall: TextStyle(
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w700, // Bold
            fontSize: 48,
          ),
          headlineMedium: TextStyle(
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w600, // SemiBold
            fontSize: 34,
            letterSpacing: 0.25,
          ),
          headlineSmall: TextStyle(
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w500, // Medium
            fontSize: 24,
          ),
          titleLarge: TextStyle(
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w400, // Regular
            fontSize: 20,
            letterSpacing: 0.15,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w400, // Regular
            fontSize: 16,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w300, // Light
            fontSize: 14,
          ),
          bodySmall: TextStyle(
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w200, // ExtraLight
            fontSize: 12,
          ),
          labelSmall: TextStyle(
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w100, // Thin
            fontSize: 10,
          ),
        ),
      ),
      home: const LandingScreen(),
    );
  }
}
