import 'package:flutter/material.dart';
import 'package:hospy/constants/value_const.dart';
import 'package:hospy/widgets/custom_text_field.dart';

class EnterDetailWidget extends StatelessWidget {
  const EnterDetailWidget({
    super.key,
    required TextEditingController firstNameController,
    required TextEditingController secondNameController,
    required TextEditingController emailController,
    required TextEditingController nationalIDNameController,
    required TextEditingController nationalIDNumberController,
  })  : _firstNameController = firstNameController,
        _secondNameController = secondNameController,
        _emailController = emailController,
        _nationalIDNameController = nationalIDNameController,
        _nationalIDNumberController = nationalIDNumberController;

  final TextEditingController _firstNameController;
  final TextEditingController _secondNameController;
  final TextEditingController _emailController;
  final TextEditingController _nationalIDNameController;
  final TextEditingController _nationalIDNumberController;

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
          label: "National ID Type",
          hintText: "Enter the name of your National ID",
          keyboardType: TextInputType.text,
          fieldController: _nationalIDNameController,
          obscure: true,
        ),
        gapLarge,
        CustomTextFormField(
          label: "National ID Number",
          hintText: "Enter the National ID  number",
          keyboardType: TextInputType.text,
          fieldController: _nationalIDNumberController,
          obscure: true,
        ),
      ],
    );
  }
}
