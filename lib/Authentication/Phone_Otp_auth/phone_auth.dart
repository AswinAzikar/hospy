import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'package:hospy/Authentication/Phone_Otp_auth/widgets/enter_otp_svg.dart';
import 'package:hospy/Authentication/Phone_Otp_auth/widgets/input_number_svg.dart';
import 'package:hospy/bottom_navigation/bottom_navbar.dart';
import 'package:hospy/constants/color_const.dart';
import 'package:hospy/constants/value_const.dart';
import 'package:hospy/greeting_screen/GreetingScreen.dart';
import 'package:hospy/widgets/buttons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widgets/input_phone_number.dart';

final otpStateProvider = StateProvider<bool>((ref) => false);
final loadingStateProvider = StateProvider<bool>((ref) => false);
final verificationIdProvider = StateProvider<String?>((ref) => null);
final phoneNumberProvider = StateProvider<String?>((ref) => null);
final countryCodeProvider = StateProvider<String>((ref) => '');

class PhoneAuth extends ConsumerWidget {
  const PhoneAuth({super.key});

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_token', token);
    logger.w("Token saved to shared preferences");
  }

  bool _isValidPhoneNumber(String phoneNumber) {
    // Check if phone number is exactly 10 digits
    return phoneNumber.length == 10 &&
        RegExp(r'^[6-9]\d{9}$').hasMatch(phoneNumber);
  }

  Future<void> _sendOTP(
      WidgetRef ref, String phoneNumber, String countryCode) async {
    if (_isValidPhoneNumber(phoneNumber)) {
      ref.read(loadingStateProvider.notifier).state = true;

      final FirebaseAuth _auth = FirebaseAuth.instance;

      await _auth.verifyPhoneNumber(
        phoneNumber: '$countryCode$phoneNumber',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          ref.read(loadingStateProvider.notifier).state = false;
          ScaffoldMessenger.of(ref.context).showSnackBar(
            SnackBar(content: Text('Verification failed: ${e.message}')),
          );
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          ref.read(otpStateProvider.notifier).state = true;
          ref.read(verificationIdProvider.notifier).state = verificationId;
          ref.read(loadingStateProvider.notifier).state = false;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          ref.read(verificationIdProvider.notifier).state = verificationId;
          ref.read(loadingStateProvider.notifier).state = false;
        },
      );
    } else {
      ScaffoldMessenger.of(ref.context).showSnackBar(
        const SnackBar(content: Text('Invalid phone number')),
      );
    }
  }

  Future<void> _verifyOTP(WidgetRef ref, String smsCode) async {
    final verificationId = ref.read(verificationIdProvider);

    if (verificationId != null) {
      try {
        final FirebaseAuth _auth = FirebaseAuth.instance;
        final PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: smsCode,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          final String? token = await user.getIdToken();
          if (token != null) {
            logger.w("The token is $token");
            await saveToken(token);
          }

          final FirebaseFirestore firestore = FirebaseFirestore.instance;
          final DocumentReference userDocRef =
              firestore.collection('users').doc(user.uid);
          final DocumentSnapshot<Object?> userDoc = await userDocRef.get();

          if (!userDoc.exists) {
            Navigator.push(
              ref.context,
              PageTransition(
                child: GreetingScreen(credentials: credential),
                type: PageTransitionType.rightToLeft,
              ),
            );
          } else {
            Navigator.pushReplacement(
              ref.context,
              MaterialPageRoute(
                builder: (context) =>
                    const CustomBottomNavigationBar(pageIndex: 0),
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(ref.context).showSnackBar(
            const SnackBar(content: Text('Sign-in failed')),
          );
        }
      } catch (e) {
        logger.f("Error is $e");
      }
    } else {
      ScaffoldMessenger.of(ref.context).showSnackBar(
        const SnackBar(content: Text('Verification ID is not set')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOTPSent = ref.watch(otpStateProvider);
    final isLoading = ref.watch(loadingStateProvider);
    final phoneNumber = ref.watch(phoneNumberProvider) ?? '';
    final countryCode = ref.watch(countryCodeProvider);

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    TextTheme textStyleTheme = Theme.of(context).textTheme;

    final phoneController = TextEditingController(text: phoneNumber);
    final countryCodeController = TextEditingController(text: countryCode);

    return Scaffold(
      backgroundColor: bgColor1,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: bgColor1,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          isOTPSent ? 'Otp Verification' : 'Login with Phone number',
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
                  isOTPSent
                      ? EnterOtpSVG(screenHeight: screenHeight)
                      : InputPhoneNumberSVG(screenHeight: screenHeight),
                  gapLarge,
                  isOTPSent
                      ? const Text("Enter the OTP from your Phone.")
                      : const Text(
                          "Enter your mobile number to continue.",
                          style: TextStyle(fontSize: 15),
                        ),
                  gapMedium,
                  isOTPSent
                      ? OtpTextField(
                          fillColor: primaryColor1,
                          filled: true,
                          enabledBorderColor: Colors.black,
                          obscureText: true,
                          textStyle:
                              textStyleTheme.bodyLarge!.copyWith(fontSize: 15),
                          showFieldAsBox: true,
                          numberOfFields: 6,
                          borderColor: Colors.black,
                          focusedBorderColor: Colors.red,
                          showCursor: true,
                          fieldWidth: screenWidth * .0999,
                          fieldHeight: screenWidth * .0999,
                          onSubmit: (String code) {
                            _verifyOTP(ref, code);
                          },
                        )
                      : InputPhoneNumber(
                          phoneController: phoneController,
                          countryCode: countryCodeController,
                        ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : isOTPSent
                      ? LoadingButtonV1(
                          onPressed: () {
                            final otpController = TextEditingController();
                            if (ref.read(verificationIdProvider) != null) {
                              _verifyOTP(ref, otpController.text);
                            }
                          },
                          text: "Verify",
                        )
                      : LoadingButtonV1(
                          onPressed: () => _sendOTP(
                            ref,
                            phoneController.text.trim(),
                            countryCodeController.text.trim(),
                          ),
                          text: 'Send OTP',
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
