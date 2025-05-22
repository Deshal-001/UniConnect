import 'package:uniconnect_app/feature/university/domain/entity/university.dart';

import '../../../../core/configs/usecase.dart';
import '../../../../core/utils/typedefs.dart';
import '../../data/repository/uni_repositroy.dart';

class GetAllUniversities implements UsecaseWithoutParams<List<University>> {
  const GetAllUniversities(this._repository);

  final UniversityRepository _repository;

  @override
  ResultFuture<List<University>> call() async => _repository.getAllUniversities( );
}


