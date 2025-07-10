import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../../../core/constants/token_constants.dart';
import '../../../../core/exception/api_exeption.dart';
import '../../../../core/network/token_controller.dart';
import '../../data/data_sources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository.dart';
import '../../../university/domain/entity/university.dart';

class AuthRepoImplementation implements AuthenticationRepository {
  final AuthApiRemoteDataSource api;

  AuthRepoImplementation(this.api);

  @override
  Future<Either<Failure, String>> login(String email, String password) async {
    try {
      final params = {
        'email': email,
        'password': password,
      };
      final response = await api.login(params);

      if (response.token.isEmpty) {
        throw const ApiException(
            statusCode: '401', message: 'Invalid credentials');
      }
      // Store the JWT token
      await TokenController.storeTokens({
        TokenConstants.jwt: response.token,
      });

      Logger().i('Login successful, token: ${response.token}');

      return Right(response.token);
    } on DioException catch (e) {
      return Left(ApiException.fromDioException(e));
    } catch (e) {
      return const Left(ApiException(
          message: 'Unexpected error occurred', statusCode: '500'));
    }
  }

  @override
  Future<Either<Failure, String>> signup({
    required String email,
    required String password,
    required String fullName,
    required String location,
    required DateTime birthday,
    required int uniId,
  }) async {
    try {
      final params = {
        'email': email,
        'password': password,
        'fullName': fullName,
        'location': location,
        'birthday': birthday.toIso8601String(),
        'uniId': uniId,
      };
      final response = await api.signup(params);

      if (response.token.isEmpty) {
        throw const ApiException(
            statusCode: '401', message: 'Invalid credentials');
      }
      // Store the JWT token
      await TokenController.storeTokens({
        TokenConstants.jwt: response.token,
      });

      return Right(response.token);
    } on DioException catch (e) {
      return Left(ApiException.fromDioException(e));
    } catch (e) {
      return const Left(ApiException(
          message: 'Unexpected error occurred', statusCode: '500'));
    }
  }

  @override
  Future<Either<Failure, List<University>>> findUni(String prefix) async {
    try {
      final response = await api.findUni(prefix);
      return Right(response);
    } on DioException catch (e) {
      return Left(ApiException.fromDioException(e));
    } catch (e) {
      return const Left(ApiException(
          message: 'Unexpected error occurred', statusCode: '500'));
    }
  }
}
