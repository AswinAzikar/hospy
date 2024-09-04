import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? name;
  String? email;
  String? address;
  double? latitude;
  List<String>? familyMembers;
  String? profilePhoto;

  UserModel({
    this.name,
    this.email,
    this.address,
    this.latitude,
    this.familyMembers,
    this.profilePhoto,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
