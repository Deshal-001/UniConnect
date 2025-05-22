part of 'uni_bloc.dart';


sealed class UnoversityState extends Equatable {
  const UnoversityState();

  @override
  List<Object> get props => [];
}

final class UniversityInitial extends UnoversityState {
  const UniversityInitial();
}


final class FindUniversityLoading extends UnoversityState {
  const FindUniversityLoading();
}

final class FindUniversitySuccess extends UnoversityState {
  const FindUniversitySuccess(this.universities);

  final List<University> universities;

  @override
  List<Object> get props => [universities];
}
final class FindUniversityError extends UnoversityState {
  const FindUniversityError(this.message, this.statusCode);

  final String message;
  final String statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

final class GetAllUniversitiesLoading extends UnoversityState {
  const GetAllUniversitiesLoading();
}
final class GetAllUniversitiesSuccess extends UnoversityState {
  const GetAllUniversitiesSuccess(this.universities);

  final List<University> universities;

  @override
  List<Object> get props => [universities];
}
final class GetAllUniversitiesError extends UnoversityState {
  const GetAllUniversitiesError(this.message, this.statusCode);

  final String message;
  final String statusCode;

  @override
  List<Object> get props => [message, statusCode];
}


