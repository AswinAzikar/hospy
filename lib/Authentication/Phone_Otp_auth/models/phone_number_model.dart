class PhoneNumberModel {
  final String phoneNumber;
  // final String countryCode;

  PhoneNumberModel({required this.phoneNumber});

  String get formattedNumber =>
      phoneNumber; // No space between country code and phone number

  @override
  String toString() => formattedNumber;
}
