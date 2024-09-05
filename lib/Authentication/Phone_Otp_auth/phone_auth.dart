import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'package:hospy/Authentication/Phone_Otp_auth/widgets/enter_otp_svg.dart';
import 'package:hospy/Authentication/Phone_Otp_auth/widgets/input_number_svg.dart';
import 'package:hospy/bottom_navigation/bottom_navbar.dart';
import 'package:hospy/constants/color_const.dart';
import 'package:hospy/constants/value_const.dart';

import 'package:hospy/widgets/buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widgets/input_phone_number.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  bool _isOTPSend = false;
  bool _isLoading = false;
  String? _verificationId;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_token', token);
    logger.w("Token saved to  shared preferences");
  }

  bool _isValidPhoneNumber(String phoneNumber) {
    final RegExp phoneRegex = RegExp(r'^[6-9]\d{9}$');
    return phoneRegex.hasMatch(phoneNumber);
  }

  void _sendOTP() async {
    String phoneNumber = _phoneController.text;
    String countryCode = _countryController.text;

    if (_isValidPhoneNumber(phoneNumber)) {
      setState(() {
        _isLoading = true;
      });

      await _auth.verifyPhoneNumber(
        phoneNumber: '$countryCode$phoneNumber',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Verification failed: ${e.message}')),
          );
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          setState(() {
            _isOTPSend = true;
            _verificationId = verificationId;
            _isLoading = false;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _verificationId = verificationId;
            _isLoading = false;
          });
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid phone number')),
      );
    }
  }

  void _verifyOTP(String smsCode) async {
    if (_verificationId != null) {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId!,
          smsCode: smsCode,
        );

        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        User? user = userCredential.user;

        if (user != null) {
          String? token = await user.getIdToken();
          if (token != null) {
            logger.w("The token is $token");
            await saveToken(token);
          }

          FirebaseFirestore firestore = FirebaseFirestore.instance;
          DocumentReference userDocRef =
              firestore.collection('users').doc(user.uid);

          DocumentSnapshot<Object?> userDoc = await userDocRef.get();

          if (!userDoc.exists) {
            // Create a new user document
            await userDocRef.set({
              'name': user.displayName ?? 'Anonymous',
              'email': 'jestin@gmail.com',
              // Add more fields as necessary
            });
          }

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const CustomBottomNavigationBar()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sign-in failed')),
          );
        }
      } catch (e) {
        logger.f("Error is $e");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Verification ID is not set')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    TextTheme textStyleTheme = Theme.of(context).textTheme;
    return Scaffold(
      // backgroundColor: primaryColor1,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          _isOTPSend ? 'Otp Verification' : 'Login with Phone number',
          style: const TextStyle(color: Colors.black54),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              child: Column(
                children: [
                  _isOTPSend
                      ? EnterOtpSVG(screenHeight: screenHeight)
                      : InputPhoneNumberSVG(screenHeight: screenHeight),
                  gapLarge,
                  _isOTPSend
                      ? const Text("Enter the OTP from your Phone.")
                      : const Text(
                          "Enter your mobile number to continue.",
                          style: TextStyle(fontSize: 15),
                        ),
                  gapMedium,
                  _isOTPSend
                      ? OtpTextField(
                          fillColor: primaryColor1,
                          filled: true,
                          enabledBorderColor: Colors.black,
                          obscureText: true,
                          textStyle:
                              textStyleTheme.bodyLarge!.copyWith(fontSize: 15),
                          showFieldAsBox: true,
                          decoration: InputDecoration(
                            enabled: true,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                          ),
                          borderWidth: 2,
                          numberOfFields: 6,
                          borderColor: Colors.black,
                          focusedBorderColor: Colors.red,
                          showCursor: true,
                          fieldWidth: screenWidth * .0999,
                          fieldHeight: screenWidth * .0999,
                          onCodeChanged: (String code) {},
                          onSubmit: (String code) {
                            _verifyOTP(code);
                          },
                        )
                      : InputPhoneNumber(
                          phoneController: _phoneController,
                          countryCode: _countryController,
                        ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : _isOTPSend
                      ? LoadingButtonV1(
                          onPressed: () {
                            if (_verificationId != null) {
                              _verifyOTP(_otpController.text);
                            }
                          },
                          text: "Verify",
                        )
                      : LoadingButtonV1(
                          onPressed: _sendOTP,
                          text: 'Send OTP',
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
