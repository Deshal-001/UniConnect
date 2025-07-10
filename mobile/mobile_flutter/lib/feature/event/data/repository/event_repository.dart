import '../../../../core/utils/typedefs.dart';
import '../../domain/entity/event.dart';

abstract class EventRepository {
  ResultFuture<List<Event>> getAllEvents();
  ResultFuture<List<Event>> findEventByLocation(String prefix);

  // ResultFuture<List<Event>> getUpcomingEvents();
  // ResultFuture<Event> getEventById(String id);
  // ResultFuture<Event> createEvent(Event event);
  // ResultFuture<Event> updateEvent(Event event);
  // ResultFuture<void> deleteEvent(String id);
  // ResultFuture<List<Event>> getEventsByUniversityId(String universityId);
  
}
