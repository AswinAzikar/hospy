// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      name: json['name'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      familyMembers: (json['familyMembers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      profilePhoto: json['profilePhoto'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'address': instance.address,
      'latitude': instance.latitude,
      'familyMembers': instance.familyMembers,
      'profilePhoto': instance.profilePhoto,
    };
