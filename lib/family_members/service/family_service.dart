import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hospy/constants/value_const.dart';

class FamilyService {
  
  FamilyService._privateConstructor();
  
  
  static final FamilyService _instance = FamilyService._privateConstructor();
  
  
  static FamilyService get i => _instance;

  
  Future<List<Map<String, dynamic>>> loadFamilyData() async {
    try {
      final String response = await rootBundle.loadString("assets/family_members.json");
      final Map<String, dynamic> data = json.decode(response);
      return List<Map<String, dynamic>>.from(data['family_members']);
    } catch (e) {
      logger.e("Error loading family data: $e");
      return []; 
    }
  }
}