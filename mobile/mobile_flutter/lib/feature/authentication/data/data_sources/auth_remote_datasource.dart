import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:uniconnect_app/feature/university/data/model/university_model.dart';

import '../models/authentication_response_model.dart';

part 'auth_remote_datasource.g.dart'; 

@RestApi(baseUrl: "http://localhost:8080/api/auth")
abstract class AuthApiRemoteDataSource {
  factory AuthApiRemoteDataSource(Dio dio, {String baseUrl}) = _AuthApiRemoteDataSource;

  @POST("/login")
  Future<AuthenticationResponseModel> login(@Body() Map<String, dynamic> body);

  @POST("/register")
  Future<AuthenticationResponseModel> signup(@Body() Map<String, dynamic> body);

  @GET("/university")
  Future<List<UniversityModel>> getUniversities();

  @GET("university/search")
  Future<List<UniversityModel>> findUni(@Query("prefix") String prefix,);

}

class ParseErrorLogger {
  void logError(Object error, StackTrace stackTrace, RequestOptions options) {
    // Implement error logging logic here
  }
}