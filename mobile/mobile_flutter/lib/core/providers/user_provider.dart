import 'package:flutter/material.dart';

import '../../feature/authentication/domain/entities/user_class.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
