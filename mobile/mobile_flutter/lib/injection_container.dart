import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:uniconnect_app/feature/authentication/data/repositories/auth_repository.dart';
import 'package:uniconnect_app/feature/authentication/domain/use_cases/login_usecase.dart';
import 'package:uniconnect_app/feature/authentication/presentation/bloc/authentication_bloc.dart';

import 'feature/authentication/data/data_sources/auth_remote_datasource.dart';
import 'feature/authentication/domain/repositories/auth_repository_impl.dart';

final sl = GetIt.instance;
Future<void> init() async {
  sl.registerLazySingleton<Dio>(() => Dio());
/// Authentication Feature
  sl
  ..registerFactory(()=> AuthenticationBloc(
    loginUser: sl(),
  ))
  //Use Cases
  ..registerLazySingleton(()=> LoginUser(sl()))
  //Repository
  ..registerLazySingleton<AuthenticationRepository>(() => AuthRepoImplementation(
    sl()
  ))
  //Data Source
  ..registerLazySingleton(()=> AuthApiRemoteDataSource(sl()));

}
