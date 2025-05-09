import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/use_cases/login_usecase.dart';
import '../../domain/use_cases/signup_usecase.dart';


part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUser _loginUser;
  final SignUpUser _signUpUser;

  AuthenticationBloc({
    required LoginUser loginUser,
    required SignUpUser signUpUser,
  })  : _loginUser = loginUser,
        _signUpUser = signUpUser,
        super(const AuthenticationInitial()) {
    on<LoginUserEvent>(_loginUserHandler);
    on<SignUpUserEvent>(_signUpUserHandler);
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

  Future<void> _signUpUserHandler(
    SignUpUserEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const SignUpUserLoading());

    final result = await _signUpUser(SignUpUserParams(
      password: event.password,
      email: event.email,
      fullName: event.fullName,
      location: event.location,
      birthday: event.birthday,
      uniId: event.uniId,
    ));

    result.fold(
      (failure) => emit(SignUpUserError(failure.message, failure.statusCode)),
      
      (success) {
        emit(const SignUpUserSuccess());
      },
    );
  }
}
