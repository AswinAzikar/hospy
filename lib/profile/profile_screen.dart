import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:hospy/constants/color_const.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColorfulSafeArea(
      topColor: buttonColor,
      child: Scaffold(
        backgroundColor: bgColor1,
        body: Center(
          child: Text("Profile Screen"),
        ),
      ),
    );
  }
}
