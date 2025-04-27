
import 'package:uniconnect_app/core/utils/typedefs.dart';

abstract class AuthenticationRepository {
  ResultFuture<String> login(String email, String password);
}
