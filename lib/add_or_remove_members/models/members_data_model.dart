import 'package:json_annotation/json_annotation.dart';

part 'members_data_model.g.dart';

@JsonSerializable()
class FamilyMember {
  String id;
  String name;
  int age;
  String relation;
  String adhaarNo;
  String phoneNumber;

  FamilyMember({
    required this.id,
    required this.name,
    required this.age,
    required this.relation,
    required this.adhaarNo,
    required this.phoneNumber,
  });

  // From JSON
  factory FamilyMember.fromJson(Map<String, dynamic> json) =>
      _$FamilyMemberFromJson(json);

  // To JSON
  Map<String, dynamic> toJson() => _$FamilyMemberToJson(this);
}
