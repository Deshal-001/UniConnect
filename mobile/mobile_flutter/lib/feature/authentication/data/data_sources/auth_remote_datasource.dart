import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../models/authentication_response_model.dart';

part 'auth_api_service.g.dart';


@RestApi(baseUrl: "http://localhost:8080/api/auth")
abstract class AuthApiRemoteDataSource {
  factory AuthApiRemoteDataSource(Dio dio, {String baseUrl}) = _AuthApiRemoteDataSource;

  @POST("/login")
  Future<AuthenticationResponseModel> login(@Body() Map<String, dynamic> body);
}

class ParseErrorLogger {
  void logError(Object error, StackTrace stackTrace, RequestOptions options) {
    // Implement error logging logic here
  }
}