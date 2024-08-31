import 'package:flutter/material.dart';
import 'package:hospy/constants/color_const.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: bgColor1,
      body: Center(
        child: Text("sign up screen"),
      ),
    );
  }
}
