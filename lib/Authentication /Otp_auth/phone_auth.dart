import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hospy/Authentication%20/Otp_auth/widgets/InputNumberSVG.dart';
import 'package:hospy/constants/color_const.dart';
import 'package:hospy/constants/value_const.dart';
import 'package:hospy/gen/assets.gen.dart';
import 'package:gap/gap.dart';
import 'package:hospy/widgets/buttons.dart';

import 'widgets/input_phone_number.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  bool _isOTPSend = false;
  bool _isValidPhoneNumber(String phoneNumber) {
    final RegExp phoneRegex = RegExp(r'^[6-9]\d{9}$');
    return phoneRegex.hasMatch(phoneNumber);
  }

  void _sendOTP() async {
    String phoneNumber = _phoneController.text.trim();

    if (_isValidPhoneNumber(phoneNumber)) {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.verifyPhoneNumber(
        phoneNumber: '+91$phoneNumber',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          logger.e(e.message);
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          setState(() {
            _isOTPSend = !_isOTPSend;
            logger.t("_isOTP set to true");
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }

  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              child: Column(
                children: [
                  InputPhoneNumberSVG(screenHeight: screenHeight),
                  gapLarge,
                  const Text(
                    "Enter your mobile number to continue.",
                    style: TextStyle(fontSize: 15),
                  ),
                  gapMedium,
                  InputPhoneNumber(phoneController: _phoneController),
                  gapMedium,
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LoadingButtonV1(onPressed: _sendOTP, text: 'Send OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
