import 'package:flutter/material.dart';
import 'package:hospy/route_const/route_const.dart';
import 'package:page_transition/page_transition.dart';

class CustomButtonForMenu extends StatelessWidget {
  const CustomButtonForMenu({
    super.key,
    required this.textStyleTheme,
    required this.title,
    required this.leftIcon,
    required this.rightIcon, required this.navigateTo,
  });

  final TextTheme textStyleTheme;
  final String title;
  final IconData leftIcon;
  final IconData rightIcon;
  final Widget  navigateTo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushTo(
            context: context,
            toPage: navigateTo,
            style: PageTransitionType.rightToLeft);
      },
      enableFeedback: true,
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(leftIcon),
            Text(title, style: textStyleTheme.bodyLarge),
            Icon(rightIcon)
          ],
        ),
      ),
    );
  }
}
