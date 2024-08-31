import 'package:flutter/material.dart';
import 'package:hospy/constants/color_const.dart';
import 'package:hospy/home_screen/home_screen.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
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
        children: const <Widget>[
          HomeScreen(),
        ],
      ),
     bottomNavigationBar: StylishBottomBar(
        items: [
          BottomBarItem(
              icon: const Icon(Icons.home_outlined), title: const Text('Home'))
        ],
        option:
            DotBarOptions(dotStyle: DotStyle.tile, gradient: primaryGradience),
            fabLocation: StylishBarFabLocation.end,
            hasNotch: true,
            currentIndex:selectedIndex ,
            onTap: (index){
              setState(() {
                selectedIndex=index;
                _pageController.jumpToPage(index);
              });
            },
      ),
    );
  }
}
