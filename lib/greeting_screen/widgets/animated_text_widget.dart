import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:hospy/constants/color_const.dart';

class AnimatedWelcomeText extends StatelessWidget {
  const AnimatedWelcomeText({
    super.key,
    required this.welcomeText,
    required this.textStyleTheme,
    required this.screenWidth,
    required this.screenHeight,
  });

  final String welcomeText;
  final TextTheme textStyleTheme;
  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.26,
      width: double.maxFinite,
      child: AnimatedTextKit(animatedTexts: [
        TypewriterAnimatedText(
          welcomeText,
          textStyle: textStyleTheme.displayLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.15,
              color: primaryColor2),
          speed: Durations.short2,
          cursor: '_',
        ),
      ]),
    );
  }
}
