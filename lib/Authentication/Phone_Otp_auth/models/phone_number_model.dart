class PhoneNumberModel {
  final String phoneNumber;
  final String countryCode;

  PhoneNumberModel({required this.phoneNumber, required this.countryCode});

  String get formattedNumber =>
      '$countryCode$phoneNumber'; // No space between country code and phone number

  @override
  String toString() => formattedNumber;
}
