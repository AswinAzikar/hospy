import 'package:flutter/material.dart';

ThemeData fontTheme = ThemeData(
  // Define the default font family
  fontFamily: 'SFProDisplay',

  // Define different text styles
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'SFProDisplay',
      fontWeight: FontWeight.w900, // Black
      fontSize: 96,
      letterSpacing: -1.5,
    ),
    displayMedium: TextStyle(
      fontFamily: 'SFProDisplay',
      fontWeight: FontWeight.w800, // ExtraBold
      fontSize: 60,
      letterSpacing: -0.5,
    ),
    displaySmall: TextStyle(
      fontFamily: 'SFProDisplay',
      fontWeight: FontWeight.w700, // Bold
      fontSize: 48,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'SFProDisplay',
      fontWeight: FontWeight.w600, // SemiBold
      fontSize: 34,
      letterSpacing: 0.25,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'SFProDisplay',
      fontWeight: FontWeight.w500, // Medium
      fontSize: 24,
    ),
    titleLarge: TextStyle(
      fontFamily: 'SFProText',
      fontWeight: FontWeight.w400, // Regular
      fontSize: 20,
      letterSpacing: 0.15,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'SFProText',
      fontWeight: FontWeight.w400, // Regular
      fontSize: 16,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'SFProText',
      fontWeight: FontWeight.w300, // Light
      fontSize: 14,
    ),
    bodySmall: TextStyle(
      fontFamily: 'SFProText',
      fontWeight: FontWeight.w200, // ExtraLight
      fontSize: 12,
    ),
    labelSmall: TextStyle(
      fontFamily: 'SFProText',
      fontWeight: FontWeight.w100, // Thin
      fontSize: 10,
    ),
  ),
);
