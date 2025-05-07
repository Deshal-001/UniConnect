part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

final class AuthenticatingUser extends AuthenticationState {
  const AuthenticatingUser();
}

final class UserAuthenticated extends AuthenticationState {
  const UserAuthenticated();
}

final class UserAuthenticatingError extends AuthenticationState {
  const UserAuthenticatingError(this.message, this.statusCode);

  final String message;
  final String statusCode;

  @override
  List<Object> get props => [message, statusCode];
}
