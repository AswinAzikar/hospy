import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hospy/add_or_remove_members/models/members_data_model.dart';

import '../../constants/value_const.dart';

class FamilyService {
  FamilyService._privateConstructor();
  static final FamilyService _instance = FamilyService._privateConstructor();
  static FamilyService get i => _instance;

  Future<List<FamilyMember>> loadFamilyData() async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/family_members.json');

      Map<String, dynamic> jsonObject =
          jsonDecode(jsonString) as Map<String, dynamic>;

      List<dynamic> jsonList = jsonObject['family_members'] as List<dynamic>;

      return jsonList
          .map((json) => FamilyMember.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
    logger.e('Error loading family data: $e');
      return [];
    }
  }
}
