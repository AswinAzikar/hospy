import 'package:flutter/material.dart';

const Color bgColor1 = Color(0xffF6F6F6);
const Color buttonColor = Colors.black;

const Color containerColor = Colors.white;

const primaryColor1 = Color(0xffffe1e1);
const primaryColor2 = Color(0xffef7878);
const primaryColor3 = Color(0xffecfff6);

const LinearGradient primaryGradience = LinearGradient(
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
  colors: [primaryColor2, primaryColor1],
);

List<BoxShadow> commonShadow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.2), // Shadow color with opacity
    blurRadius: 10, // Softens the shadow
    offset: const Offset(0, 5), // Offset in x and y direction
    spreadRadius: 1, // Spread radius to enlarge the shadow
  ),
];

List<Color> multiGradientColorList = [
  const Color.fromARGB(255, 204, 250, 238).withOpacity(.004),
  const Color.fromARGB(255, 205, 241, 223).withOpacity(.004),
  const Color.fromARGB(255, 240, 218, 241).withOpacity(.004),
  const Color.fromARGB(255, 221, 245, 255).withOpacity(.004),
];
