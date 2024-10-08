import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hospy/bottom_navigation/bottom_navbar.dart';
import 'package:hospy/greeting_screen/GreetingScreen.dart';
import 'package:hospy/landing_screen/landing_screen.dart';
import 'package:hospy/theme/theme.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const ProviderScope(child: MyApp()),
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: fontTheme,
      debugShowCheckedModeBanner: false,
      home: const LandingScreen(),
    );
  }
}
