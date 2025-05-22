import 'package:uniconnect_app/core/utils/typedefs.dart';
import 'package:uniconnect_app/feature/university/domain/entity/university.dart';

abstract class AuthenticationRepository {
  ResultFuture<String> login(String email, String password);
  ResultFuture<String> signup({
    required String email,
    required String password,
    required String fullName,
    required String location,
    required DateTime birthday,
    required int uniId,
  });

  ResultFuture<List<University>> findUni(String prefix);
}
