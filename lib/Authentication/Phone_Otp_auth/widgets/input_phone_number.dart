import 'package:flutter/material.dart';
import 'package:intl_phone_number_field/intl_phone_number_field.dart';


class InputPhoneNumber extends StatelessWidget {
  const InputPhoneNumber({
    super.key,
    required TextEditingController phoneController,
    required TextEditingController countryCode,
  })  : _phoneController = phoneController,
        _countryController = countryCode;

  final TextEditingController _phoneController;

  final TextEditingController _countryController;

  @override
  Widget build(BuildContext context) {
    _countryController.text = "+91";
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: InternationalPhoneNumberInput(
                onInputChanged: (number) {
                  _countryController.text = number.dial_code;
                },
                controller: _phoneController,
                initCountry: CountryCodeModel(
                    name: "India", dial_code: "+91", code: "IN"),
                validator: (value) {
                  if (value.number.isEmpty) {
                    return "The phone number must  not be empty";
                  }
                  if (value.number.length != 10) {
                    return "The phone number must be 10 digits.";
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
