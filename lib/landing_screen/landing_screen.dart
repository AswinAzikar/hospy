import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hospy/Authentication/Phone_Otp_auth/phone_auth.dart';

import 'package:hospy/constants/color_const.dart';
import 'package:hospy/gen/assets.gen.dart';
import 'package:hospy/widgets/buttons.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    final ScreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: ScreenHeight * 0.001,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: primaryColor1,
            statusBarIconBrightness: Brightness.dark),
      ),
      backgroundColor: primaryColor1,
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 10,
              child: SizedBox(
                child: SvgPicture.asset(Assets.svg.care),
              )),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3),
                      child: LoadingButtonV1(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PhoneAuth(),
                            ),
                          );
                        },
                        text: "Get Started",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
