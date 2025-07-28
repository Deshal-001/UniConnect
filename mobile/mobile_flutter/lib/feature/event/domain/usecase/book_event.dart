import 'package:uniconnect_app/core/configs/usecase.dart';

import '../../../../core/utils/typedefs.dart';
import '../../data/repository/event_repository.dart';
import '../entity/event.dart';

class BookEventUsecase implements UsecaseWithParams<Event, BookEventParams> {
  final EventRepository _repository;

  const BookEventUsecase(this._repository);

  @override
  ResultFuture<Event> call(BookEventParams params) async {
    return await _repository.bookEvent(params.eventId);
  }
}

class BookEventParams {
  final int eventId;

  const BookEventParams({required this.eventId});

  List<Object?> get props => [eventId];
}
