import 'package:flutter/material.dart';
import 'package:hospy/constants/color_const.dart';
import 'package:hospy/constants/value_const.dart';
import 'package:hospy/home_screen/home_screen.dart';
import 'package:hospy/profile/profile_screen.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int selectedIndex = 0;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        children: const <Widget>[HomeScreen(), ProfileScreen()],
      ),
      bottomNavigationBar: StylishBottomBar(

        
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        elevation: 20,
        notchStyle: NotchStyle.themeDefault,
        items: [
          BottomBarItem(
              selectedColor: buttonColor,
              icon: const Icon(Icons.home_outlined),
              title: const Text(
                'Home',
                style: TextStyle(color: buttonColor),
              )),
          BottomBarItem(
              selectedColor: buttonColor,
              icon: const Icon(Icons.person),
              title: const Text(
                "Profile",
                style: TextStyle(color: buttonColor),
              ))
        ],
        option: DotBarOptions(
          dotStyle: DotStyle.tile,
          gradient: primaryGradience,
        ),
        fabLocation: StylishBarFabLocation.end,
        hasNotch: true,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
            _pageController.jumpToPage(index);
          });
        },
      ),
    );
  }
}
