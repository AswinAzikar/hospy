import 'package:flutter/material.dart';
import 'package:hospy/Authentication%20/Phone_Otp_auth/phone_auth.dart';
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
    return Scaffold(
      backgroundColor: bgColor1,
      body: Stack(
        children: [
          AspectRatio(
              aspectRatio: .45,
              child: Image.asset(Assets.png.landingImagePng.path,
                  fit: BoxFit.cover)),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
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
                                builder: (context) => const PhoneAuth()));
                      },
                      text: "Get Started",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
