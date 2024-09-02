import 'package:flutter/material.dart';

import '../../widgets/custom_text_field.dart';

class DetailWidget extends StatelessWidget {
  const DetailWidget({
    super.key,
    required TextEditingController nameController,
    required TextEditingController ageController,
    required TextEditingController emailController,
    required TextEditingController addressController,
  })  : _nameController = nameController,
        _ageController = ageController,
        _emailController = emailController,
        _addressController = addressController;

  final TextEditingController _nameController;
  final TextEditingController _ageController;
  final TextEditingController _emailController;
  final TextEditingController _addressController;

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        //   CustomTextFormField(
        //     label: "Name : ",
        //     keyboardType: TextInputType.name,
        //     fieldController: _nameController,
        //   ),
        //   CustomTextFormField(
        //     label: "Age :",
        //     keyboardType: TextInputType.number,
        //     fieldController: _ageController,
        //   ),
        //   CustomTextFormField(
        //     label: "Email :",
        //     keyboardType: TextInputType.emailAddress,
        //     fieldController: _emailController,
        //   ),
        //   CustomTextFormField(
        //       label: "Address :",
        //       keyboardType: TextInputType.multiline,
        //       fieldController: _addressController),
      ],
    );
  }
}
