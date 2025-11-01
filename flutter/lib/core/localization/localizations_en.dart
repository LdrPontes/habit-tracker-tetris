// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Starter';

  @override
  String get authErrorGoogleSignInFailed =>
      'Google sign in failed. Please try again.';

  @override
  String get authErrorGoogleIdTokenNotFound =>
      'Sorry, we couldn\'t sign you in with Google. Please try again.';

  @override
  String get authErrorAppleSignInFailed =>
      'Apple sign in failed. Please try again.';

  @override
  String get authErrorUnknownError =>
      'An unknown error occurred. Please try again.';

  @override
  String get authErrorAppleIdTokenNotFound =>
      'Sorry, we couldn\'t sign you in with Apple. Please try again.';
}
