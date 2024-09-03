import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:hospy/constants/color_const.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const ColorfulSafeArea(
      topColor: buttonColor,
      child: Scaffold(
        backgroundColor: bgColor1,
        body: Center(child: Text("Home Screen")),
      ),
    );
  }
}
