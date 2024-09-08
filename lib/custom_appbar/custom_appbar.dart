import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hospy/constants/color_const.dart';

class CustomAppBarWithStatusBar extends StatelessWidget
    implements PreferredSizeWidget {
  final double appBarHeight;
  final Color statusBarColor;
  final Brightness statusBarIconBrightness;
  final Color? appBarColor;
  final double? appBarElevation;

  const CustomAppBarWithStatusBar({
    super.key,
    required this.appBarHeight,
    required this.statusBarColor,
    required this.statusBarIconBrightness,
    this.appBarColor,
    this.appBarElevation,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: appBarHeight,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: statusBarIconBrightness,
      ),
      backgroundColor: appBarColor ?? Colors.transparent,
      elevation: appBarElevation ?? 0, 
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
