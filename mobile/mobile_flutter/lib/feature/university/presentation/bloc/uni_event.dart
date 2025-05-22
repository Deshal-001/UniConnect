part of 'uni_bloc.dart';

sealed class UniversityEvent extends Equatable {
  const UniversityEvent();

  @override
  List<Object> get props => [];
}


class FindUniversityEvent extends UniversityEvent {
  const FindUniversityEvent(this.prefix);

  final String prefix;

  @override
  List<Object> get props => [prefix];
}

class GetAllUniversitiesEvent extends UniversityEvent {
  const GetAllUniversitiesEvent();
}
