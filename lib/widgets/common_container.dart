import 'package:flutter/material.dart';
import 'package:hospy/constants/color_const.dart';
import 'package:hospy/constants/value_const.dart';

class CommonContainer extends StatelessWidget {
  final Widget child;

  final VoidCallback? onPressed;

  final Color? backgroundColor;
  const CommonContainer({
    super.key,
    required this.child,
    this.backgroundColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed ??
            () {
              logger.w("Container Tapped for a void purpose");
            },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: backgroundColor ?? containerColor,
            boxShadow: commonShadow,
          ),
          child: Padding(padding: const EdgeInsets.all(8.0), child: child),
        ));
  }
}
