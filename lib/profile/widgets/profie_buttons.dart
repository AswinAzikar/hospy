import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hospy/widgets/common_container.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
    required this.screenWidth,
    required this.textStyleTheme,
    required this.iconPath,
    required this.label,
    required this.onPressed,
  });
  final String iconPath;
  final double screenWidth;
  final TextTheme textStyleTheme;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CommonContainer(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  height: screenWidth * .1,
                  iconPath,
                ),
                Text(
                  label,
                  style: textStyleTheme.bodyLarge,
                ),
                const Icon(Icons.arrow_forward_ios)
              ],
            ),
          ],
        ),
      )),
    );
  }
}
