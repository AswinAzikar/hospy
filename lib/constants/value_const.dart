import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:logger/logger.dart';
import 'package:styled_divider/styled_divider.dart';

// Extra Small Gaps
const gapExtraSmall = Gap(4);

// Small Gaps
const gapTiny = Gap(2);
const gapVerySmall = Gap(6);
const gapSmall = Gap(8);

// Medium Gaps
const gapMedium = Gap(12);
const gapNormal = Gap(14);
const gapMediumLarge = Gap(18);

// Large Gaps
const gapLarge = Gap(16);

// Roman Style Gaps
const gapXL = Gap(24); // Extra Large
const gapXXL = Gap(32); // Double Extra Large
const gapXXXL = Gap(40); // Triple Extra Large

// Extra Large Gaps with Roman Numerals
const gapIV = Gap(48); // Four times large
const gapV = Gap(56); // Five times large
const gapVI = Gap(64); // Six times large
const gapVII = Gap(72); // Seven times large
const gapVIII = Gap(80); // Eight times large
const gapIX = Gap(96); // Nine times large
const gapX = Gap(104); // Ten times large

var logger = Logger();

// Function to calculate dynamic border radius
double calculateDynamicRadius(double width, double height,
    {double factor = 0.1}) {
  // Find the smaller dimension (width or height)
  double minDimension = min(width, height);

  // Calculate radius based on the given factor (default is 10% of the smaller dimension)
  return minDimension * factor;
}

final customDivider = StyledDivider(
  color: Colors.grey[300],
  thickness: 2,
  lineStyle: DividerLineStyle.dashed,
  indent: 20,
  endIndent: 20,
);
