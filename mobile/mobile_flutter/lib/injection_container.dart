import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:uniconnect_app/feature/authentication/data/repositories/auth_repository.dart';
import 'package:uniconnect_app/feature/authentication/domain/use_cases/login_usecase.dart';
import 'package:uniconnect_app/feature/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:uniconnect_app/feature/university/presentation/bloc/uni_bloc.dart';

import 'core/network/token_controller.dart';
import 'feature/authentication/data/data_sources/auth_remote_datasource.dart';
import 'feature/authentication/domain/repositories/auth_repository_impl.dart';
import 'feature/authentication/domain/use_cases/signup_usecase.dart';
import 'feature/event/data/data_source/event_remote_datasource.dart';
import 'feature/event/data/repository/event_repository.dart';
import 'feature/event/domain/repository/event_repo_impl.dart';
import 'feature/event/domain/usecase/get_all_events.dart';
import 'feature/event/presentation/bloc/event_bloc.dart';
import 'feature/university/data/data_source/uni_remote_datasource.dart';
import 'feature/university/data/repository/uni_repositroy.dart';
import 'feature/university/domain/repo_implementation/uni_repository_impl.dart';
import 'feature/university/domain/usecase/find_uni_usecase.dart';
import 'feature/university/domain/usecase/get_all_uni_usecase.dart';

final sl = GetIt.instance;
Future<void> init() async {
  // Dio with Bearer token interceptor
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await TokenController.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
    return dio;
  });
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
  ..registerLazySingleton(() => UniApiRemoteDataSource(sl()))

  //Event Feature
  // sl
  ..registerFactory(() => EventBloc(getAllEvents: sl()))
  //Use Cases
  ..registerLazySingleton(() => GetAllEvents(sl()))
  //Repository
  ..registerLazySingleton<EventRepository>(() => EventRepoImplementation(sl()))
  //Data Source
  ..registerLazySingleton(() => EventApiRemoteDataSource(sl()));
}
