import 'package:uniconnect_app/core/configs/usecase.dart';

import '../../../../core/utils/typedefs.dart';
import '../../data/repository/event_repository.dart';
import '../entity/event.dart';

class GetAllEvents implements UsecaseWithoutParams<List<Event>> {
  final EventRepository _repository;

  const GetAllEvents(this._repository);

  @override
  ResultFuture<List<Event>> call() async {
    return await _repository.getAllEvents();
  }
}
