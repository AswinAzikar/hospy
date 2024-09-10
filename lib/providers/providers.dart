import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for managing OTP state
final otpStateProvider = StateProvider<bool>((ref) => false);

// Provider for managing loading state
final loadingStateProvider = StateProvider<bool>((ref) => false);

// Provider for managing verification ID
final verificationIdProvider = StateProvider<String?>((ref) => null);

// Provider for managing phone number and country code
final phoneNumberProvider = StateProvider<String?>((ref) => null);
final countryCodeProvider = StateProvider<String>((ref) => '');
