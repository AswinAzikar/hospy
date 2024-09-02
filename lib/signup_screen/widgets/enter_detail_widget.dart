import 'package:flutter/material.dart';
import 'package:hospy/constants/value_const.dart';
import 'package:hospy/widgets/custom_text_field.dart';

class EnterDetailWidget extends StatelessWidget {
  const EnterDetailWidget({
    super.key,
    required TextEditingController firstNameController,
    required TextEditingController secondNameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _firstNameController = firstNameController,
        _secondNameController = secondNameController,
        _emailController = emailController,
        _passwordController = passwordController;

  final TextEditingController _firstNameController;
  final TextEditingController _secondNameController;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          label: "First Name",
          hintText: "Enter your first name",
          keyboardType: TextInputType.name,
          fieldController: _firstNameController,
        ),
        gapLarge,
        CustomTextFormField(
            hintText: "Enter you second name",
            label: "Second Name",
            keyboardType: TextInputType.name,
            fieldController: _secondNameController),
        gapLarge,
        CustomTextFormField(
          label: "Email ",
          keyboardType: TextInputType.emailAddress,
          fieldController: _emailController,
          hintText: "Enter your email address",
        ),
        gapLarge,
        CustomTextFormField(
          label: "Password",
          hintText: "Set up a new password",
          keyboardType: TextInputType.text,
          fieldController: _passwordController,
          obscure: true,
        ),
        gapLarge,
        CustomTextFormField(
          label: "Confirm Password",
          hintText: "Confirm your password",
          keyboardType: TextInputType.text,
          fieldController: _passwordController,
          obscure: true,
        ),
      ],
    );
  }
}
