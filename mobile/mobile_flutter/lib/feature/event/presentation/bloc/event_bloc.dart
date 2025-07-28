import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entity/event.dart';
import '../../domain/usecase/get_all_events.dart';
import '../../domain/usecase/book_event.dart';
import '../../domain/usecase/get_booked_events.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final GetAllEvents _getAllEvents;
  final BookEventUsecase _bookEvent;
  final GetBookedEventUsecase _getBookedEvent;
  

  EventBloc({
    required GetAllEvents getAllEvents,
    required BookEventUsecase bookEvent,
    required GetBookedEventUsecase getBookedEvent,
  })  : _getAllEvents = getAllEvents,
        _bookEvent = bookEvent,
        _getBookedEvent = getBookedEvent,
        super(const EventInitial()) {
    on<FetchEvents>(_fetchEventsHandler);
    on<BookEvent>(_bookEventHandler);
    on<FindBookedEventsByUserId>(_findBookedEventsByUserIdHandler);
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

  Future<void> _bookEventHandler(
    BookEvent event,
    Emitter<EventState> emit,
  ) async {
    emit(const BookingLoading());

    final result = await _bookEvent(BookEventParams(eventId: event.eventId));
    result.fold(
      (failure) => emit(BookingError(failure.message, failure.statusCode)),
      (success) => emit(BookingSuccess(success)),
    );
  }

  Future<void> _findBookedEventsByUserIdHandler(
    FindBookedEventsByUserId event,
    Emitter<EventState> emit,
  ) async {
    emit(const FindBookedEventsByUserIdLoading());

    final result =
        await _getBookedEvent(GetBookedEventParams(userId: event.userId));
    result.fold(
      (failure) => emit(FindBookedEventsByUserIdError(failure.message, failure.statusCode)),
      (success) => emit(FindBookedEventsByUserIdSuccess(success)),
    );
  }
}
