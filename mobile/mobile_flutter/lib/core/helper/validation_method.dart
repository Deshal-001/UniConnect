class ValidationMethod {
  bool isValidEmail(String email) {
    final RegExp regex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }
  bool isValidPassword(String password) {
    return password.length >= 8;
  }
  bool isValidFullName(String fullName) {
    final RegExp regex = RegExp(r'^[a-zA-Z\s]+$');
    return regex.hasMatch(fullName);
  }

  bool isPasswordsMatch(
      String password, String repeatPassword) {
    return password == repeatPassword;
  }
} 