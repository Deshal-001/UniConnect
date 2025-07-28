import 'package:uniconnect_app/core/configs/usecase.dart';

import '../../../../core/utils/typedefs.dart';
import '../../data/repository/event_repository.dart';
import '../entity/event.dart';

class GetBookedEventUsecase implements UsecaseWithParams<List<Event>, GetBookedEventParams> {
  final EventRepository _repository;

  const GetBookedEventUsecase(this._repository);

  @override
  ResultFuture<List<Event>> call(GetBookedEventParams params) async {
    return await _repository.findBookedEventsByUserId(params.userId);
  }
}

class GetBookedEventParams {
  final int userId;

  const GetBookedEventParams({required this.userId});

  List<Object?> get props => [userId];
}
