import 'package:flutter/material.dart';
import 'package:hospy/constants/color_const.dart';
import 'package:hospy/constants/value_const.dart';
import 'package:hospy/signup_screen/widgets/enter_detail_widget.dart';
import 'package:hospy/widgets/buttons.dart';
import 'package:hospy/widgets/custom_text_field.dart';

import 'widgets/signup_text_widget.dart';

class SighupScreen extends StatefulWidget {
  const SighupScreen({super.key});

  @override
  State<SighupScreen> createState() => _SighupScreenState();
}

class _SighupScreenState extends State<SighupScreen> {
  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _secondNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  // final TextEditingController _ageController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _ischecked = true;

// void _onPressedChecKBox(bool value){
//   setState(() {
//     _ischecked = !_ischecked;
//   });
// }
  @override
  Widget build(BuildContext context) {
    TextTheme textStyleTheme = Theme.of(context).textTheme;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: bgColor1,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 0, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SignupTextWidget(
                screenWidth: screenWidth,
                textStyleTheme: textStyleTheme,
              ),
              gapLarge,
              gapLarge,
              EnterDetailWidget(
                  firstNameController: _firstNameController,
                  secondNameController: _secondNameController,
                  emailController: _emailController,
                  passwordController: _passwordController),
              gapLarge,
              Row(
                children: [
                  Checkbox(
                      activeColor: primaryColor2,
                      value: _ischecked,
                      onChanged: (_) {
                        setState(() {
                          _ischecked = !_ischecked;
                        });
                      }),
                  Column(
                    children: [
                      Row(
                        children: [
                          RichText(
                              softWrap: true,
                              text: TextSpan(
                                  style: textStyleTheme.bodySmall,
                                  text: "By tapping this, you agree to our ",
                                  children: [
                                    TextSpan(
                                      style: textStyleTheme.bodySmall!.copyWith(
                                          color: primaryColor2,
                                          fontWeight: FontWeight.bold),
                                      text: "Terms & conditions.",
                                    )
                                  ]))
                        ],
                      )
                    ],
                  )
                ],
              ),
              LoadingButtonV1(onPressed: () {}, text: "Continue"),
            ],
          ),
        ),
      ),
    );
  }
}
