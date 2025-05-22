import 'package:json_annotation/json_annotation.dart';
import 'package:uniconnect_app/feature/university/domain/entity/university.dart';
import 'package:uniconnect_app/feature/authentication/domain/entities/user_class.dart';

import '../../../../core/enum/role.dart';  // Import domain User class

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.fullName,
    required super.role,
    required super.university,
    super.imgUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
