import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hospy/Authentication/Phone_Otp_auth/phone_auth.dart';
import 'package:hospy/bottom_navigation/bottom_navbar.dart';
import 'package:hospy/constants/color_const.dart';
import 'package:hospy/constants/value_const.dart';
import 'package:hospy/widgets/buttons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'widgets/signup_text_widget.dart';
import 'widgets/enter_detail_widget.dart';

class SignUpScreen extends ConsumerWidget {
  final PhoneAuthCredential phoneAuthCredential;

  const SignUpScreen({
    super.key,
    required this.phoneAuthCredential,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneNumber = ref.watch(phoneNumberProvider);
    final countryCode = ref.watch(countryCodeProvider);
    final FirebaseAuth auth = FirebaseAuth.instance;

    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController secondNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController nationalDNameController = TextEditingController();
    final TextEditingController nationalIDNumberontroller =
        TextEditingController();

    bool firstNameEmpty = false;
    bool secondNameEmpty = false;
    bool emailEmpty = false;
    bool nationalDNameEmpty= false;
    bool nationalIDNumberEmpty = false;
    bool isChecked = false;

    void validateFields() {
      firstNameEmpty = firstNameController.text.isEmpty;
      secondNameEmpty = secondNameController.text.isEmpty;
      emailEmpty = emailController.text.isEmpty;
      nationalDNameEmpty= nationalDNameController.text.isEmpty;
     nationalIDNumberEmpty = nationalIDNumberontroller.text.isEmpty;
    }

    Future<void> launchURL() async {
      const url = 'https://www.lipsum.com/';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    Future<void> saveDataToFireStore() async {
      UserCredential userCredential =
          await auth.signInWithCredential(phoneAuthCredential);
      User? user = userCredential.user;

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference userDocRef =
          firestore.collection('users').doc(user!.uid);

      // Create phoneAuthCredential new user document
      await userDocRef.set({
        'name': "${firstNameController.text} ${secondNameController.text}",
        'email': emailController.text,
        'phone': '$countryCode$phoneNumber',
        // Add more fields as necessary
      });
    }

    void validateTheFieldAndMoveToNextPage() {
      validateFields();

      if (firstNameEmpty ||
          secondNameEmpty ||
          emailEmpty ||
          nationalDNameEmpty||
         nationalIDNumberEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Please fill in all the fields.",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red,
        ));
      }  else if (!isChecked) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Please agree to our Terms and Conditions.",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red,
        ));
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor1,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SignupTextWidget(
                  screenWidth: MediaQuery.of(context).size.width,
                  textStyleTheme: Theme.of(context).textTheme,
                ),
                gapLarge,
                gapLarge,
                EnterDetailWidget(
                  firstNameController: firstNameController,
                  secondNameController: secondNameController,
                  emailController: emailController,
                 nationalIDNameController:nationalDNameController , nationalIDNumberController: nationalIDNumberontroller,
                ),
                gapLarge,
                Row(
                  children: [
                    Checkbox(
                      activeColor: primaryColor2,
                      value: isChecked,
                      onChanged: (_) {
                        // setState(() {
                        //   _isChecked = !_isChecked;
                        // });
                      },
                    ),
                    GestureDetector(
                      onTap: launchURL,
                      child: RichText(
                        softWrap: true,
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodySmall,
                          text: "By tapping this, you agree to our ",
                          children: [
                            TextSpan(
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: primaryColor2,
                                    fontWeight: FontWeight.bold,
                                  ),
                              text: "Terms & conditions.",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (firstNameEmpty ||
                    secondNameEmpty ||
                    emailEmpty ||
                    nationalDNameEmpty||
                   nationalIDNumberEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (firstNameEmpty)
                          Text('* First name is required',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600)),
                        if (secondNameEmpty)
                          Text('* Second name is required',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600)),
                        if (emailEmpty)
                          Text('* Email is required',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600)),
                        if (nationalDNameEmpty)
                          Text('* Kindly enter your national ID',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600)),
                        if (nationalIDNumberEmpty)
                          Text('* Enter national ID number',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600)),
                       
                      ],
                    ),
                  ),
                LoadingButtonV1(
                  onPressed: validateTheFieldAndMoveToNextPage,
                  text: "Continue",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
