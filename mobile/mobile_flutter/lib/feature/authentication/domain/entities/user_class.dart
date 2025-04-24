import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uniconnect_app/core/enum/role.dart';
import 'package:uniconnect_app/feature/authentication/domain/entities/university.dart';

part 'user_class.g.dart';

@JsonSerializable()
class User extends Equatable {
  final int id;
  final String email;
  final String fullName;
  final Role role;
  final University university;

  const User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    required this.university,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
        id,
        email,
        fullName,
        role,
        university,
      ];

  @override
  bool get stringify => true;

  @override
  String toString() {
    return 'User { id: $id, email: $email, fullName: $fullName, role: $role, university: $university }';
  }
}
