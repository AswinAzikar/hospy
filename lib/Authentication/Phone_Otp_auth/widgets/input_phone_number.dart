import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hospy/providers/providers.dart';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../models/phone_number_model.dart';

class InputPhoneNumber extends ConsumerStatefulWidget {
  const InputPhoneNumber({
    super.key,
    required this.phoneController,
    required this.countryCodeController,
  });

  final TextEditingController phoneController;
  final TextEditingController countryCodeController;

  @override
  ConsumerState<InputPhoneNumber> createState() => _InputPhoneNumberState();
}

class _InputPhoneNumberState extends ConsumerState<InputPhoneNumber> {
  PhoneNumber initialPhoneNumber = PhoneNumber(isoCode: 'IN');

  @override
  void initState() {
    super.initState();
    widget.countryCodeController.text = '+91';
  }

  @override
  Widget build(BuildContext context) {
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
                onInputChanged: (PhoneNumber number) {
                  final countryCode = number.dialCode ?? '+91';
                  final phoneNumber = number.phoneNumber ?? '';

                  ref.read(phoneNumberProvider.notifier).state =
                      PhoneNumberModel(
                          phoneNumber: phoneNumber, countryCode: countryCode);
                },
                initialValue: initialPhoneNumber,
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.DROPDOWN,
                ),
                inputDecoration: InputDecoration(
                  hintText: "Phone number",
       
                  hintStyle: TextStyle(color: Colors.grey[300]),
                  border: InputBorder.none,
                  //    labelText: 'Phone Number',
                ),
                textFieldController: widget.phoneController,
                formatInput: true,
                keyboardType: TextInputType.phone,
                onSaved: (PhoneNumber number) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "The phone number must not be empty";
                  }
                  if (value.length < 10 || value.length > 10) {
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
