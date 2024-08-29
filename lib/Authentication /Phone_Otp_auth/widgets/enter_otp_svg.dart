import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hospy/gen/assets.gen.dart';

class EnterOtpSVG extends StatelessWidget {
  double screenHeight;
  EnterOtpSVG({
    super.key,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      height: screenHeight * 0.25,
      Assets.svg.enterOtp,
      fit: BoxFit.contain,
    );
  }
}
