import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:uniconnect_app/feature/university/data/model/university_model.dart';

import '../../../authentication/data/data_sources/auth_remote_datasource.dart';


part 'uni_remote_datasource.g.dart'; 

@RestApi(baseUrl: "http://localhost:8080/api/")
abstract class UniApiRemoteDataSource {
  factory UniApiRemoteDataSource(Dio dio, {String baseUrl}) = _UniApiRemoteDataSource;


  @GET("university")
  Future<List<UniversityModel>> getUniversities();

  @GET("university/search")
  Future<List<UniversityModel>> findUni(@Query("prefix") String prefix,);

}


