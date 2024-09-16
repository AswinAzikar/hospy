import 'package:json_annotation/json_annotation.dart';

part 'members_data_model.g.dart';

@JsonSerializable()
class FamilyMember {
  String id;
  String name;
  String age;
  String relation;
  @JsonKey(name: 'adhaar no') 
  String? adhaarNo; 
  @JsonKey(name: 'phone number') 
  String? phoneNumber; 

  FamilyMember({
    required this.id,
    required this.name,
    required this.age,
    required this.relation,
    this.adhaarNo,
    this.phoneNumber,
  });

  
  factory FamilyMember.fromJson(Map<String, dynamic> json) =>
      _$FamilyMemberFromJson(json);

  
  Map<String, dynamic> toJson() => _$FamilyMemberToJson(this);
}
