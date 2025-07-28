part of 'event_bloc.dart';

sealed class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

final class EventInitial extends EventState {
  const EventInitial();
}

final class EventLoading extends EventState {
  const EventLoading();
}

final class EventLoaded extends EventState {
  const EventLoaded(this.events);

  final List<Event> events;

  @override
  List<Object> get props => [events];
}

final class EventError extends EventState {
  const EventError(this.message, this.statusCode);

  final String message;
  final String statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

final class BookingLoading extends EventState {
  const BookingLoading();
}

final class BookingSuccess extends EventState {
  const BookingSuccess(this.event);

  final Event event;

  @override
  List<Object> get props => [event];
}

final class BookingError extends EventState {
  const BookingError(this.message
  , this.statusCode);

  final String message;
  final String statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

final class FindBookedEventsByUserIdLoading extends EventState {
  const FindBookedEventsByUserIdLoading();
}

final class FindBookedEventsByUserIdSuccess extends EventState {
  const FindBookedEventsByUserIdSuccess(this.events);

  final List<Event> events;

  @override
  List<Object> get props => [events];
}

final class FindBookedEventsByUserIdError extends EventState {
  const FindBookedEventsByUserIdError(this.message, this.statusCode);

  final String message;
  final String statusCode;

  @override
  List<Object> get props => [message, statusCode];
}