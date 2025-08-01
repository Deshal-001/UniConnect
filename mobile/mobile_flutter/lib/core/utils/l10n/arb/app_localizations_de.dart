// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get welcomeTitle => 'Willkommen!';

  @override
  String get welcomeSubtitle => 'Melden Sie sich an oder erstellen Sie ein neues Konto';

  @override
  String get signIn => 'Anmelden';

  @override
  String get noAccount => 'Noch kein Konto?';

  @override
  String get signUp => 'Registrieren';

  @override
  String get english => 'Englisch';

  @override
  String get german => 'Deutsch';

  @override
  String get welcomeBack => 'Willkommen zurück!';

  @override
  String get emailLabel => 'E-Mail-Adresse';

  @override
  String get emailHint => 'name@example.com';

  @override
  String get passwordLabel => 'Passwort';

  @override
  String get passwordHint => 'Geben Sie Ihr Passwort ein';

  @override
  String get signInButton => 'Registrieren';

  @override
  String get loginSuccessTitle => 'Erfolg';

  @override
  String get loginSuccessMessage => 'Registrierung erfolgreich';

  @override
  String get loginFailedTitle => 'Registrierung fehlgeschlagen';

  @override
  String loginFailedMessage(Object message, Object statusCode) {
    return 'Fehler $statusCode: $message';
  }

  @override
  String get okButton => 'OK';

  @override
  String get fullNameLabel => 'Vollständiger Name';

  @override
  String get fullNameHint => 'Geben Sie Ihren vollständigen Namen ein';

  @override
  String get birthdayLabel => 'Geburtstag';

  @override
  String get birthdayHint => 'TT/MM/JJJJ';

  @override
  String get universityLabel => 'Wählen Sie Ihre Universität';

  @override
  String get universityHint => 'Universität';

  @override
  String get repeatPasswordLabel => 'Passwort wiederholen';

  @override
  String get repeatPasswordHint => 'Wiederholen Sie das neue Passwort';

  @override
  String get createNewAccount => 'Neues konto Erstellen';
}
