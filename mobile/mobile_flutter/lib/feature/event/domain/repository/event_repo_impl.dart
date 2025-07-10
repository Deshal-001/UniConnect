import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import 'package:uniconnect_app/feature/event/domain/entity/event.dart';

import '../../../../core/exception/api_exeption.dart';
import '../../data/data_source/event_remote_datasource.dart';
import '../../data/repository/event_repository.dart';

class EventRepoImplementation implements EventRepository {
  final EventApiRemoteDataSource api;

  EventRepoImplementation(this.api);

    @override
  Future<Either<Failure, List<Event>>> findEventByLocation(String prefix) async {
    try {
      final response = await api.findUniByLocation(prefix);
      return Right(response);
    } on DioException catch (e) {
      return Left(ApiException.fromDioException(e));
    } catch (e) {
      return const Left(ApiException(
          message: 'Unexpected error occurred', statusCode: '500'));
    }
  }
  @override
  Future<Either<Failure, List<Event>>> getAllEvents() async {
    try {
      final response = await api.getEvents();
      return Right(response);
    } on DioException catch (e) {
      Logger().e('Error fetching events: ${e.message}');
      return Left(ApiException.fromDioException(e));
    } catch (e) {
      return const Left(ApiException(
          message: 'Unexpected error occurred', statusCode: '500'));
    }
  }

}

