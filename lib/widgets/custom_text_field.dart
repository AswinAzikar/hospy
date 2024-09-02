import 'package:flutter/material.dart';
import 'package:hospy/constants/color_const.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.label,
    required this.hintText,
    required TextInputType keyboardType,
    required TextEditingController fieldController,
    this.validator, this.obscure,
  })  : _keyboardType = keyboardType,
        _fieldController = fieldController;

  final String label;
  final String hintText;
  final TextInputType _keyboardType;
  final TextEditingController _fieldController;
  final String? Function(String?)? validator;
  final bool? obscure ;

  @override
  Widget build(BuildContext context) {
    double borderRadius = 40.0;
    return TextFormField(
      obscureText:  obscure ?? false,
      keyboardType: _keyboardType,
      controller: _fieldController,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        focusColor: primaryColor2,
        filled: true,
        fillColor: Colors.white,
        labelText: label,
        hintText: hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.grey),
        labelStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: primaryColor2,
            width: 1.0,
          ),
        ),
      ),
      validator: validator,
    );
  }
}
