import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../../../core/constants/token_constants.dart';
import '../../../../core/exception/api_exeption.dart';
import '../../../../core/network/token_controller.dart';
import '../../data/data_sources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository.dart';

class AuthRepoImplementation implements AuthenticationRepository {
  final AuthApiRemoteDataSource api;

  AuthRepoImplementation(
    this.api,
  );

  @override
  Future<Either<Failure, String>> login(String email, String password) async {
    Logger().i('Login attempt with email: $email and password: $password');
    try {
      final params = {
        'email': email,
        'password': password,
      };
      final response = await api.login(params);
      if (response.token.isEmpty) {
        throw const ApiException(statusCode: '401',message:  'Invalid credentials');
      }
      // Store the JWT token securely
      TokenController.storeTokens({
        TokenConstants.jwt: response.token,
      });
      return Right(response.token);
    } on DioException catch (e) {
     
      return Left(
        ApiException
        .fromDioException(e)
      );
    } catch (e) {
      return 
      Left(ApiException(message: '500', statusCode: 'Unexpected error: ${e.toString()}'));
    }
  }

  // @override
  // Future<String> register({required String email, required String password, required String fullName}) async {
  //   final response = await api.register({
  //     'email': email,
  //     'password': password,
  //     'fullName': fullName,
  //   });
  //   await storage.write(key: 'jwt', value: response.token);
  //   return response.token;
  // }
}
