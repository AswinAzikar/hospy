import 'package:flutter/material.dart';
import 'package:hospy/constants/color_const.dart';
import 'package:hospy/constants/value_const.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required TextInputType keyboardType,
    required TextEditingController fieldController,
  })  : _keyboardType = keyboardType,
        _fieldController = fieldController;

  final String label;
  final TextInputType _keyboardType;
  final TextEditingController _fieldController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              gapMedium,
              Text(label),
            ],
          ),
          TextField(
            keyboardType: _keyboardType,
            controller: _fieldController,
            decoration: InputDecoration(
              filled: true,
              fillColor: primaryColor1,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
