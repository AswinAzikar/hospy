import 'package:flutter/material.dart';
import 'package:hospy/constants/color_const.dart';
import 'package:hospy/constants/value_const.dart';
import 'package:hospy/signup_screen/widgets/enter_detail_widget.dart';
import 'package:hospy/theme/theme.dart';
import 'package:hospy/widgets/buttons.dart';

import 'package:url_launcher/url_launcher.dart';

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
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _firstNameEmpty = false;
  bool _secondNameEmpty = false;
  bool _emailEmpty = false;
  bool _passwordEmpty = false;
  bool _confirmPasswordEmpty = false;
  bool _ischecked = true;
  // final bool _canValidate = false;

  void _validateFields() {
    setState(() {
      _firstNameEmpty = _firstNameController.text.isEmpty;
      _secondNameEmpty = _secondNameController.text.isEmpty;
      _emailEmpty = _emailController.text.isEmpty;
      _passwordEmpty = _passwordController.text.isEmpty;
      _confirmPasswordEmpty = _confirmPasswordController.text.isEmpty;
    });
  }

  Future<void> _launchURL() async {
    const url = 'https://www.lipsum.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _validateTheFieldAndMoveToNextPage() {
    _validateFields();

    if (!_firstNameEmpty &&
        !_secondNameEmpty &&
        !_emailEmpty &&
        !_passwordEmpty &&
        _confirmPasswordController.text == _passwordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Processing Data'),
          backgroundColor: primaryColor2,
        ),
      );
    }

    if (_confirmPasswordController.text != _passwordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Please confirm your pasword. ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textStyleTheme = Theme.of(context).textTheme;
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
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
                  passwordController: _passwordController,
                  confirmPasswordController: _confirmPasswordController,
                ),
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
                      },
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: _launchURL,
                              child: RichText(
                                softWrap: true,
                                text: TextSpan(
                                  style: textStyleTheme.bodySmall,
                                  text: "By tapping this, you agree to our ",
                                  children: [
                                    TextSpan(
                                      style: textStyleTheme.bodySmall!.copyWith(
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
                      ],
                    ),
                  ],
                ),
                if (_firstNameEmpty ||
                    _secondNameEmpty ||
                    _emailEmpty ||
                    _passwordEmpty ||
                    _confirmPasswordEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_firstNameEmpty)
                          Text('* First name is required',
                              style: textStyleTheme.bodySmall!.copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600)),
                        if (_secondNameEmpty)
                          Text('* Second name is required',
                              style: textStyleTheme.bodySmall!.copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600)),
                        if (_emailEmpty)
                          Text('* Email is required',
                              style: textStyleTheme.bodySmall!.copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600)),
                        if (_passwordEmpty)
                          Text('* Password is required',
                              style: textStyleTheme.bodySmall!.copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600)),
                        if (_confirmPasswordEmpty)
                          Text('* Please confirm your password',
                              style: textStyleTheme.bodySmall!.copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600)),
                        if (_passwordController.text !=
                            _confirmPasswordController.text)
                          Text('* password Error',
                              style: textStyleTheme.bodySmall!.copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                LoadingButtonV1(
                  onPressed: _validateTheFieldAndMoveToNextPage,
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
