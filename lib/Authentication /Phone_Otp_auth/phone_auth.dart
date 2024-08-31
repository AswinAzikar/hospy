import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:hospy/Authentication%20/Phone_Otp_auth/widgets/enter_otp_svg.dart';
import 'package:hospy/Authentication%20/Phone_Otp_auth/widgets/input_number_svg.dart';
import 'package:hospy/bottom_navigation/bottom_navbar.dart';
import 'package:hospy/constants/color_const.dart';
import 'package:hospy/constants/value_const.dart';
import 'package:hospy/home_screen/home_screen.dart';
import 'package:hospy/signup_screen/signup_screen.dart';
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
    await prefs.setString('user_token',
        token); //shared  preferences storing token to key user_token
    logger.w("Token saved to  shared preferences");
  }

  bool _isValidPhoneNumber(String phoneNumber) {
    final RegExp phoneRegex = RegExp(r'^[6-9]\d{9}$');
    return phoneRegex.hasMatch(phoneNumber);
  }

//send otp  function
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

//verify otp and save token
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

          // Get the instance of Firestore
          FirebaseFirestore firestore = FirebaseFirestore.instance;

          // Get the document snapshot
          DocumentSnapshot<Map<String, dynamic>> userDoc =
              await firestore.collection('users').doc(user.uid).get();

          if (userDoc.exists) {
            // User exists, navigate to CustomBottomNavigationBar
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const CustomBottomNavigationBar()),
            );
          } else {
            // User doesn't exist, navigate to signup page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SignupScreen()),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sign-in failed')),
          );
        }
      } catch (e) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Error during OTP verification: $e')),

        
        // );
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

    return Scaffold(
      appBar: AppBar(
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
                          borderWidth: 2,
                          numberOfFields: 6,
                          borderColor: Colors.black,
                          focusedBorderColor: Colors.blue,
                          showCursor: true,
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
