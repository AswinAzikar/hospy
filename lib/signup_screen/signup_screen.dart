import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hospy/constants/color_const.dart';
import 'package:hospy/constants/value_const.dart';
import 'package:hospy/gen/assets.gen.dart';
import 'package:hospy/signup_screen/widgets/detail_widget.dart';
import 'package:hospy/signup_screen/widgets/signup_buttons.dart';
import 'package:hospy/widgets/buttons.dart';
import 'package:hospy/widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isScrolled = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _isScrolled = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: primaryColor1,
      body: Stack(
        children: [
          SvgPicture.asset(Assets.svg.tellUsMore),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: _isScrolled ? screenHeight * 0.7 : 0,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      DetailWidget(
                        nameController: _nameController,
                        ageController: _ageController,
                        emailController: _emailController,
                        addressController: _addressController,
                      ),
                      Gap(screenHeight * 0.07),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: LoadingButtonV1(
                          iconLeft: false,
                          onPressed: () {},
                          text: "Next",
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
