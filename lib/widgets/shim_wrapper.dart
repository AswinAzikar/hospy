import 'package:flutter/material.dart';
import 'package:hospy/constants/color_const.dart';
import 'package:shimmer/shimmer.dart';

class ShimWrapper extends StatelessWidget {
  final Widget child;
  final Gradient gradientColors;

  ShimWrapper({
    super.key,
    required this.child,
    Gradient? gradientColors,
  }) : gradientColors = gradientColors ?? defaultGradient;

  // Default gradient
  static final Gradient defaultGradient = LinearGradient(
    colors: [Colors.grey.shade600, Colors.grey.shade100],
    stops: const [0.2, 0.8],
  );

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      direction: ShimmerDirection.ltr,
      period: Durations.medium4,
      gradient: gradientColors,
      child: Container(
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(8)),
        child: child,
      ),
    );
  }
}
