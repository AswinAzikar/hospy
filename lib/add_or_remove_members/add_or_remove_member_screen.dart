import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hospy/bottom_navigation/bottom_navbar.dart';
import 'package:page_transition/page_transition.dart';

import '../constants/color_const.dart';
import '../route_const/route_const.dart';

class AddOrRemoveMemberScreen extends StatefulWidget {
  const AddOrRemoveMemberScreen({super.key});

  @override
  State<AddOrRemoveMemberScreen> createState() =>
      _AddOrRemoveMemberScreenState();
}

class _AddOrRemoveMemberScreenState extends State<AddOrRemoveMemberScreen> {
  @override
  Widget build(BuildContext context) {
    Color pageColor = bgColor1;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Members",
        ),
        leading: IconButton(
            onPressed: () {
              pushTo(
                context: context,
                toPage: const CustomBottomNavigationBar(),
                style: PageTransitionType.leftToRight,
              );
            },
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: pageColor,
        ),
      ),
    );
  }
}
