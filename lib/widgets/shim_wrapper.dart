import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimWrapper extends StatelessWidget {
  final Widget child;
  final Gradient gradientColors;

  const ShimWrapper({
    super.key,
    required this.child,
    Gradient? gradientColors,
  }) : gradientColors = gradientColors ?? premiumGradient;

  // Premium gradient
  static const Gradient premiumGradient = LinearGradient(
    colors: [
      Color(0xFF6D6D6D), // Dark grey
      Color(0xFFBEBEBE), // Light grey
      Color(0xFFF2F2F2), // Almost white
    ],
    stops: [0.2, 0.5, 0.8],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      direction: ShimmerDirection.ltr,
      period: const Duration(milliseconds: 1500), // Duration for shimmer effect
      gradient: gradientColors,
      child: Container(
        decoration: BoxDecoration(
          color: Colors
              .grey.shade300, // Fallback color if shimmer effect is not visible
          borderRadius: BorderRadius.circular(8),
        ),
        child: child,
      ),
    );
  }
}
