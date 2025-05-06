import 'package:equatable/equatable.dart';

class ApiException implements Exception {
  final String errorCode;
  final String message;

  ApiException(this.errorCode, this.message);

  @override
  String toString() => '$errorCode: $message';

}

abstract class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}