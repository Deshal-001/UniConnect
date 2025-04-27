import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/use_cases/login_usecase.dart';


part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUser _loginUser;

  AuthenticationBloc({
    required LoginUser loginUser,
  })  : _loginUser = loginUser,
        super(const AuthenticationInitial()) {
    on<LoginUserEvent>(_loginUserHandler);
  }

  Future<void> _loginUserHandler(
    LoginUserEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const AuthenticatingUser());

    final result = await _loginUser(LoginUserParams(
      password: event.password,
      email: event.email,
    ));

    result.fold(
      (failure) => emit(UserAuthenticatingError(failure.message, failure.statusCode)),
      
      (success) {
        emit(const UserAuthenticated());
      },
    );
  }
}
