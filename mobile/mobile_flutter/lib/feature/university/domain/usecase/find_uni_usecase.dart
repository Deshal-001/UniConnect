import 'package:equatable/equatable.dart';
import 'package:uniconnect_app/feature/university/domain/entity/university.dart';

import '../../../../core/configs/usecase.dart';
import '../../../../core/utils/typedefs.dart';
import '../../../authentication/data/repositories/auth_repository.dart';

class FindUni implements UsecaseWithParams<List<University>, FindUniParams> {
  const FindUni(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<List<University>> call(FindUniParams params) async => _repository.findUni(
        params.prefix,
      );
}

class FindUniParams extends Equatable {
  const FindUniParams({
    required this.prefix
  });

  final String prefix;

  @override
  List<Object?> get props => [
        prefix,
      ];
}
