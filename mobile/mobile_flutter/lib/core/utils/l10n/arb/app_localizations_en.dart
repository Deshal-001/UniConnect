// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcomeTitle => 'Welcome!';

  @override
  String get welcomeSubtitle => 'Sign in or create a new account';

  @override
  String get signIn => 'Sign in';

  @override
  String get noAccount => 'No account yet?';

  @override
  String get signUp => 'Sign up';

  @override
  String get english => 'English';

  @override
  String get german => 'Deutsch';

  @override
  String get welcomeBack => 'Welcome Back!';

  @override
  String get emailLabel => 'Email address';

  @override
  String get emailHint => 'name@example.com';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get signInButton => 'Sign up';

  @override
  String get loginSuccessTitle => 'Success';

  @override
  String get loginSuccessMessage => 'Registration Successful';

  @override
  String get loginFailedTitle => 'Registration Failed';

  @override
  String loginFailedMessage(Object message, Object statusCode) {
    return 'Error $statusCode: $message';
  }

  @override
  String get okButton => 'OK';

  @override
  String get fullNameLabel => 'Full Name';

  @override
  String get fullNameHint => 'Enter your full name';

  @override
  String get birthdayLabel => 'Birthday';

  @override
  String get birthdayHint => 'DD/MM/YYYY';

  @override
  String get universityLabel => 'Select Your University';

  @override
  String get universityHint => 'University';

  @override
  String get repeatPasswordLabel => 'Repeat password';

  @override
  String get repeatPasswordHint => 'Repeat new password';

  @override
  String get createNewAccount => 'Create new account';
}
