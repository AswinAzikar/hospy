import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hospy/constants/value_const.dart';
import 'package:hospy/gen/assets.gen.dart';
import 'package:gap/gap.dart';

class PhoneAuth extends StatelessWidget {
  const PhoneAuth({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight * .3,
              child: SvgPicture.asset(
                Assets.svg.phoneAuth,
                fit: BoxFit.contain,
              ),
            ),
            gapLarge,
            const Text(
              "Enter you mobile number to continue.",
              style: TextStyle(fontSize: 15),
            ),


            
          ],
        ),
      ),
    );
  }
}
