import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entity/event.dart';
import '../../domain/usecase/get_all_events.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final GetAllEvents _getAllEvents;

  EventBloc({
    required GetAllEvents getAllEvents,
  })  : _getAllEvents = getAllEvents,
        super(const EventInitial()) {
    on<FetchEvents>(_fetchEventsHandler);
    // Add more event handlers as needed
  }

  Future<void> _fetchEventsHandler(
    FetchEvents event,
    Emitter<EventState> emit,
  ) async {
    emit(const EventLoading());

    final result = await _getAllEvents();
    result.fold(
      (failure) => emit(EventError(failure.message, failure.statusCode)),
      (success) => emit(EventLoaded(success)),
    );
  }
}