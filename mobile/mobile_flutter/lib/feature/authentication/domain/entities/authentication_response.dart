

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'authentication_response.g.dart';

@JsonSerializable()
class AuthenticationResponse extends Equatable {
  final String token;

  const AuthenticationResponse({
    required this.token,
  });
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
  @override
  List<Object?> get props => [
        token,
      ];
  @override
  bool get stringify => true;
  @override
  String toString() {
    return 'AuthenticationResponseModel { token: $token }';
  }
}
  

