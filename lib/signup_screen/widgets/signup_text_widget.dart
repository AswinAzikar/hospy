import 'package:flutter/material.dart';

class SignupTextWidget extends StatelessWidget {
  const SignupTextWidget({
    super.key,
    required this.screenWidth,
    required this.textStyleTheme,
  });

  final double screenWidth;
  final TextTheme textStyleTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Set up your profile",
                  style: textStyleTheme.headlineMedium,
                ),
                TextSpan(
                  text: " ✍️",
                  style: textStyleTheme.headlineMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Create an account so that you can manage your health and appointments.",
            style: textStyleTheme.bodyMedium!.copyWith(color: Colors.black87),
            softWrap: true,
          ),
        ],
      ),
    );
  }
}
