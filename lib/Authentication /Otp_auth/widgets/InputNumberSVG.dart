import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hospy/gen/assets.gen.dart';

class InputPhoneNumberSVG extends StatelessWidget {
  const InputPhoneNumberSVG({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * .3,
      child: SvgPicture.asset(
        Assets.svg.phoneAuth,
        fit: BoxFit.contain,
      ),
    );
  }
}
