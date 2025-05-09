import 'package:equatable/equatable.dart';

import '../../../../core/configs/usecase.dart';
import '../../../../core/utils/typedefs.dart';
import '../../data/repositories/auth_repository.dart';

class SignUpUser implements UsecaseWithParams<String, SignUpUserParams> {
  const SignUpUser(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<String> call(SignUpUserParams params) async =>
      _repository.signup(
        email: params.email,
        password: params.password,
        fullName: params.fullName,
        location: params.location,
        birthday: params.birthday,
        uniId: params.uniId,
      );
}

class SignUpUserParams extends Equatable {
  const SignUpUserParams({
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
  List<Object?> get props => [
        password,
        email,
        fullName,
        location,
        birthday,
        uniId,
      ];
}
