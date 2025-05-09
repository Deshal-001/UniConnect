part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class LoginUserEvent extends AuthenticationEvent {
  const LoginUserEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [
        email,
        password,
      ];
}

class SignUpUserEvent extends AuthenticationEvent {
  const SignUpUserEvent({
    required this.email,
    required this.password,
    required this.fullName,
    required this.location,
    required this.birthday,
    required this.uniId,
  });

  final String email;
  final String password;
  final String fullName;
  final String location;
  final DateTime birthday;
  final int uniId;

  @override
  List<Object> get props => [
        email,
        password,
        fullName,
        location,
        birthday,
        uniId,
      ];
}
