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