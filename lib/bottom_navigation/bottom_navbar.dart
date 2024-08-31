import 'package:flutter/material.dart';
import 'package:hospy/constants/color_const.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class BottomNavigationBar extends StatefulWidget {
  const BottomNavigationBar({super.key});

  @override
  State<BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return StylishBottomBar(
        items: const [],
        option:
            DotBarOptions(gradient: primaryGradience, dotStyle: DotStyle.tile));
  }
}
