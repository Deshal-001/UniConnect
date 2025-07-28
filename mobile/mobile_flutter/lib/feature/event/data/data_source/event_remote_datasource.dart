import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:uniconnect_app/feature/event/data/model/event_model.dart';

part 'event_remote_datasource.g.dart';

@RestApi(baseUrl: "http://localhost:8080/api/event/")
abstract class EventApiRemoteDataSource {
  factory EventApiRemoteDataSource(Dio dio, {String baseUrl}) =
      _EventApiRemoteDataSource;

  @GET("all")
  Future<List<EventModel>> getEvents();

  @GET("by-location")
  Future<List<EventModel>> findUniByLocation(
    @Query("location") String prefix,
  );

  @POST("{id}/book")
  Future<EventModel> bookEvent(@Path("id") int eventId);

  @GET("booked-by-user/{userId}")
  Future<List<EventModel>> findBookedEventsByUserId(
    @Path("userId") int userId,
  );
}
