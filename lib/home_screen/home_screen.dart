import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:hospy/constants/color_const.dart';
import 'package:hospy/custom_appbar/custom_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBarWithStatusBar(
          appBarHeight: 0,
          statusBarColor: bgColor1,
          statusBarIconBrightness: Brightness.dark),
      backgroundColor: bgColor1,
      body: Center(child: Text("Home Screen")),
    );
  }
}
