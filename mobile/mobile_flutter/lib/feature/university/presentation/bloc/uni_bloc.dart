import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:uniconnect_app/feature/university/domain/usecase/find_uni_usecase.dart';
import 'package:uniconnect_app/feature/university/domain/usecase/get_all_uni_usecase.dart';

import '../../../university/domain/entity/university.dart';
part 'uni_event.dart';
part 'uni_state.dart';


class UniversityBloc extends Bloc<UniversityEvent, UnoversityState> {
 
  final FindUni _universities;
  final GetAllUniversities _getAllUniversities;

  UniversityBloc({
   required FindUni findUniversities,
    required GetAllUniversities getAllUniversities,
  })  :    _universities = findUniversities,
        _getAllUniversities = getAllUniversities,
        super(const UniversityInitial()) {
    on<FindUniversityEvent>(_findUniversityHandler);
    on<GetAllUniversitiesEvent>(_getAllUniversitiesHandler);
  }

  Future<void> _findUniversityHandler(
    FindUniversityEvent event,
    Emitter<UnoversityState> emit,
  ) async {
    emit(const FindUniversityLoading());

    final result = await _universities(FindUniParams(prefix: event.prefix));
    Logger().d('Result: $result');
    result.fold(
      (failure) => emit(FindUniversityError(failure.message, failure.statusCode)),
      
      (success) {
        emit(FindUniversitySuccess(success));
      },
    );

  }

  Future<void> _getAllUniversitiesHandler(
    GetAllUniversitiesEvent event,
    Emitter<UnoversityState> emit,
  ) async {
    emit(const GetAllUniversitiesLoading());

    final result = await _getAllUniversities();
    result.fold(
      (failure) => emit(GetAllUniversitiesError(failure.message, failure.statusCode)),
      
      (success) {
        emit(GetAllUniversitiesSuccess(success));
      },
    );
  }
}


   

