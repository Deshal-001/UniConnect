import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode});

  final String message;
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class ApiException extends Failure {
  const ApiException({required super.message, required super.statusCode});

  static ApiException fromDioException(DioException error) {
    try {
      final responseData = error.response?.data;
      Logger().e('Error: ${responseData.toString()}');

      if (responseData == null) {
        return const ApiException(
          message: 'No response data available',
          statusCode: '500',
        );
      }

      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('errors') &&
          responseData['errors'] is List) {
        var firstError = responseData['errors'][0];
        return ApiException(
          message: firstError['message'] ?? 'An unknown error occurred',
          statusCode: firstError['errorCode'] ?? '400',
        );
      } else if (responseData is Map<String, dynamic> &&
          responseData.containsKey('message')) {
            Logger().e('Error: ${responseData['message']}');
        Logger().e('Status Code: ${responseData['errorCode']}');
        return ApiException(
          message: responseData['message'] ?? 'An unknown error occurred',
          statusCode: responseData['errorCode'] ?? '500',
        );
      } else {
        return const ApiException(
          message: 'An unknown error occurred',
          statusCode: '500',
        );
      }
    } catch (e) {
      return const ApiException(
        message: 'An unexpected error occurred',
        statusCode: '500',
      );
    }
  }
}
