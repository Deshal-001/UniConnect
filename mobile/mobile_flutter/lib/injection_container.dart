import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:uniconnect_app/feature/authentication/data/repositories/auth_repository.dart';
import 'package:uniconnect_app/feature/authentication/domain/use_cases/login_usecase.dart';
import 'package:uniconnect_app/feature/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:uniconnect_app/feature/university/presentation/bloc/uni_bloc.dart';

import 'feature/authentication/data/data_sources/auth_remote_datasource.dart';
import 'feature/authentication/domain/repositories/auth_repository_impl.dart';
import 'feature/authentication/domain/use_cases/signup_usecase.dart';
import 'feature/university/data/data_source/uni_remote_datasource.dart';
import 'feature/university/data/repository/uni_repositroy.dart';
import 'feature/university/domain/repo_implementation/uni_repository_impl.dart';
import 'feature/university/domain/usecase/find_uni_usecase.dart';
import 'feature/university/domain/usecase/get_all_uni_usecase.dart';

final sl = GetIt.instance;
Future<void> init() async {
  sl.registerLazySingleton<Dio>(() => Dio());
/// Authentication Feature
  sl
  ..registerFactory(()=> AuthenticationBloc(
    loginUser: sl(),
    signUpUser: sl(),
  ))
  //Use Cases
  ..registerLazySingleton(()=> LoginUser(sl()))
  ..registerLazySingleton(()=> SignUpUser(sl()))
  //Repository
  ..registerLazySingleton<AuthenticationRepository>(() => AuthRepoImplementation(
    sl() 
  ))
  //Data Source
  ..registerLazySingleton(()=> AuthApiRemoteDataSource(sl()));

 /// University Feature
  sl
  ..registerFactory(()=> UniversityBloc(findUniversities: sl(),
  getAllUniversities: sl(),
  ))

 //Use Cases
  // ..registerLazySingleton(() => GetUniversities(sl()))
  ..registerLazySingleton(() => FindUni(sl()))
  ..registerLazySingleton(() => GetAllUniversities(sl()))
  //Repository
  ..registerLazySingleton<UniversityRepository>(() => UniRepoImplementation(sl()))
  //Data Source
  ..registerLazySingleton(() => UniApiRemoteDataSource(sl()));
}
