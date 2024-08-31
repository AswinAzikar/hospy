import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String name;
  String email;
  String address;
  double latitude;
  List<String> familyMembers;
  String profilePhoto;

  UserModel({
    required this.name,
    required this.email,
    required this.address,
    required this.latitude,
    required this.familyMembers,
    required this.profilePhoto,
  });

//  Factory constructor to create a new UserModel instance from a map.
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  // Method to convert UserModel instance to a map.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

}