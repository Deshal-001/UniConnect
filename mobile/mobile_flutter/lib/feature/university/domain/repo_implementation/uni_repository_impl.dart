import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:uniconnect_app/core/utils/typedefs.dart';
import 'package:uniconnect_app/feature/university/data/data_source/uni_remote_datasource.dart';
import 'package:uniconnect_app/feature/university/data/repository/uni_repositroy.dart';

import '../../../../core/exception/api_exeption.dart';
import '../entity/university.dart';

class UniRepoImplementation implements UniversityRepository {
  final UniApiRemoteDataSource api;

  UniRepoImplementation(this.api);

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

  @override
  ResultFuture<List<University>> getAllUniversities() async {
    try {
      final response = await api.getUniversities();
      return Right(response);
    } on DioException catch (e) {
      Logger  ().e('Error: ${e.message}');
      return Left(ApiException.fromDioException(e));
    } catch (e) {
      Logger().e('Error: $e');
      return const Left(ApiException(
          message: 'Unexpected error occurred', statusCode: '500'));
    }
  }
}
