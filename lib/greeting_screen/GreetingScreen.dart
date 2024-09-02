import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hospy/constants/color_const.dart';

import 'package:hospy/gen/assets.gen.dart';
import 'package:hospy/greeting_screen/widgets/animated_text_widget.dart';
import 'package:hospy/signup_screen/signup_screen.dart';
import 'package:hospy/widgets/buttons.dart';
import 'package:page_transition/page_transition.dart';

class GreetingScreen extends StatefulWidget {
  const GreetingScreen({super.key});

  @override
  State<GreetingScreen> createState() => _GreetingScreenState();
}

class _GreetingScreenState extends State<GreetingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  bool _isButtonVisible = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    Future.delayed(const Duration(milliseconds: 4000), () {
      _controller.forward();
    });

    Future.delayed(const Duration(milliseconds: 3800), () {
      setState(() {
        _isButtonVisible = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String welcomeText = "Welcome ! \n Let's get\n you started.";
    TextTheme textStyleTheme = Theme.of(context).textTheme;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: bgColor1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedWelcomeText(
                welcomeText: welcomeText,
                textStyleTheme: textStyleTheme,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              SlideTransition(
                position: _slideAnimation,
                child: SizedBox(
                  child: SvgPicture.asset(
                    Assets.svg.getStarted,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              if (_isButtonVisible)
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, screenHeight * 0.077),
                  child: LoadingButtonV1(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: SighupScreen(),
                              type: PageTransitionType.rightToLeft));
                    },
                    text: "Continue",
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    iconLeft: false,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
