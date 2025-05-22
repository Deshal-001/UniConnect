import 'package:uniconnect_app/core/utils/typedefs.dart';
import 'package:uniconnect_app/feature/university/domain/entity/university.dart';

abstract class UniversityRepository {
  ResultFuture<List<University>> getAllUniversities();
  ResultFuture<List<University>> findUni(String prefix);
}
