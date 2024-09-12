import 'package:flutter/material.dart';
import 'package:hospy/constants/color_const.dart';

import 'package:hospy/home_screen/home_screen.dart';
import 'package:hospy/profile/profile_screen.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

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
      drawer: selectedIndex == 0 ? _buildDrawer() : null,
      appBar: selectedIndex == 0
          ? AppBar(
              backgroundColor: bgColor1,
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
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

  Widget _buildDrawer() {
    return Align(
      alignment: Alignment.centerLeft,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 2.5 / 4,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: const Column(
                children: [],
              ),
            ),
            Positioned.fill(
              child: AnimatedMeshGradient(
                colors: [
                  const Color.fromARGB(255, 204, 250, 238).withOpacity(.004),
                  const Color.fromARGB(255, 189, 243, 215).withOpacity(.004),
                  const Color.fromARGB(255, 240, 218, 241).withOpacity(.004),
                  const Color.fromARGB(255, 202, 233, 245).withOpacity(.004),
                ],
                options: AnimatedMeshGradientOptions(frequency: 3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
