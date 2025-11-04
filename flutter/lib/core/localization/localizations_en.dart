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

  @override
  String get authErrorUserAlreadyExists =>
      'A user with this email already exists.';

  @override
  String get authErrorUserNotFound =>
      'User not found. Please check your credentials.';

  @override
  String get authErrorUserInvalidCredentials =>
      'Invalid credentials. Please check your email and password.';

  @override
  String get authErrorEmailNotConfirmed =>
      'Please confirm your email address before signing in.';

  @override
  String get authErrorSamePassword =>
      'New password must be different from your current password.';
}
