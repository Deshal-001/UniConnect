part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

final class FetchEvents extends EventEvent {
  const FetchEvents();
}

final class FindEventByLocation extends EventEvent {
  const FindEventByLocation({required this.location});
  final String location;

  @override
  List<Object> get props => [location];
}

final class BookEvent extends EventEvent {
  const BookEvent({required this.eventId});
  final int eventId;

  @override
  List<Object> get props => [eventId];
}

final class FindBookedEventsByUserId extends EventEvent {
  const FindBookedEventsByUserId({required this.userId});
  final int userId;

  @override
  List<Object> get props => [userId];
}