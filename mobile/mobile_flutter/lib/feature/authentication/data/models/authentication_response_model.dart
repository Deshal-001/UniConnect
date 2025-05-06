

import 'package:json_annotation/json_annotation.dart';
import 'package:uniconnect_app/feature/authentication/domain/entities/authentication_response.dart';

part 'authentication_response_model.g.dart';

@JsonSerializable()
class AuthenticationResponseModel extends AuthenticationResponse {
  const AuthenticationResponseModel({
    required super.token,
  });


  factory AuthenticationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AuthenticationResponseModelToJson(this);
  
}
  

