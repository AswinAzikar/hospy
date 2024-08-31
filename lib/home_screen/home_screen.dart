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
    return const Scaffold(
      backgroundColor: bgColor1,
      body: Center(child: Text("Home Screen")),
    );
  }
}
