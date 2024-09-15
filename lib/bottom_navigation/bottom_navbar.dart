import 'package:flutter/material.dart';
import 'package:hospy/constants/color_const.dart';

import 'package:hospy/home_screen/home_screen.dart';
import 'package:hospy/profile/profile_screen.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../custom_drawer/custom_drawer.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key, this.pageIndex});
  final int? pageIndex;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late int selectedIndex;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();

    selectedIndex = widget.pageIndex ?? 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.jumpToPage(selectedIndex);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: selectedIndex == 0 ? CustomDrawer(context: context) : null,
      appBar: selectedIndex == 0
          ? AppBar(
              backgroundColor: bgColor1,
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const HugeIcon(
                        icon: HugeIcons.strokeRoundedSidebarLeft01,
                        color: Colors.black),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
            )
          : null,
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
        gradient: LinearGradient(colors: multiGradientColorList),
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
