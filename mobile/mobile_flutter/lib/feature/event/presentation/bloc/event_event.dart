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