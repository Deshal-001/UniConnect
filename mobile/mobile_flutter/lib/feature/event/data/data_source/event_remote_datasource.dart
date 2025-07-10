import 'package:dio/dio.dart';
import 'package:logger/web.dart';
import 'package:retrofit/retrofit.dart';
import 'package:uniconnect_app/feature/event/data/model/event_model.dart';

part 'event_remote_datasource.g.dart'; 

@RestApi(baseUrl: "http://localhost:8080/api/event/")
abstract class EventApiRemoteDataSource {
  factory EventApiRemoteDataSource(Dio dio, {String baseUrl}) = _EventApiRemoteDataSource;

  @GET("all")
  Future<List<EventModel>> getEvents();

  @GET("by-location")
  Future<List<EventModel>> findUniByLocation(@Query("location") String prefix,);

}
