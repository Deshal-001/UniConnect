import 'package:equatable/equatable.dart';

import '../../../../core/configs/usecase.dart';
import '../../../../core/utils/typedefs.dart';
import '../../data/repositories/auth_repository.dart';

class LoginUser implements UsecaseWithParams<String, LoginUserParams> {
  const LoginUser(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<String> call(LoginUserParams params) async => _repository.login(
        params.email,
        params.password,
      );
}

class LoginUserParams extends Equatable {
  const LoginUserParams({
    required this.email,
    required this.password,
  });

  // final String username;
  final String password;
  final String email;

  @override
  List<Object?> get props => [
        password,
        email,
      ];
}
