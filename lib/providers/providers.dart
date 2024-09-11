import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Authentication/Phone_Otp_auth/models/phone_number_model.dart';

final phoneNumberProvider = StateProvider<PhoneNumberModel>((ref) {
  return PhoneNumberModel(phoneNumber: '',);
});


