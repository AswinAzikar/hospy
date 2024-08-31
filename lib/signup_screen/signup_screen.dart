import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:hospy/constants/color_const.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    String WelcomeText = "Welcome ! Let's get you started.";
    TextTheme textStyleTheme = Theme.of(context).textTheme;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: bgColor1,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              AnimatedTextKit(animatedTexts: [
                // ColorizeAnimatedText("Welcome",
                //     textStyle: textStyleTheme.displayLarge!
                //         .copyWith(fontSize: screenWidth * 0.2),
                //     colors: [primaryColor1, primaryColor2])

                TypewriterAnimatedText(WelcomeText,
                    textStyle: textStyleTheme.displayLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.15,
                        color: primaryColor2),
                    speed: Durations.medium2,
                    cursor: '_',
                    curve: Curves.easeInOutCubic),
              ])
            ],
          ),
        )));
  }
}
