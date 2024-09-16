// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'members_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FamilyMember _$FamilyMemberFromJson(Map<String, dynamic> json) => FamilyMember(
      id: json['id'] as String,
      name: json['name'] as String,
      age: json['age'] as String,
      relation: json['relation'] as String,
      adhaarNo: json['adhaar no'] as String?,
      phoneNumber: json['phone number'] as String?,
    );

Map<String, dynamic> _$FamilyMemberToJson(FamilyMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'age': instance.age,
      'relation': instance.relation,
      'adhaar no': instance.adhaarNo,
      'phone number': instance.phoneNumber,
    };
