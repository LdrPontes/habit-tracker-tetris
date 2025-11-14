// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'blockin';

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

  @override
  String get welcome_description =>
      'Register your journey\nin a visual and\nfun way';

  @override
  String get start_button => 'Let\'s start';

  @override
  String get back => 'Back';

  @override
  String get sign_in_title => 'Sign in';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get sign_in => 'Sign in';

  @override
  String get forgot_password => 'Forgot password?';

  @override
  String get or => 'or';

  @override
  String get continue_with_google => 'Continue with Google';

  @override
  String get continue_with_apple => 'Continue with Apple';

  @override
  String get sign_up_call_to_action => 'Don\'t have an account?';

  @override
  String get sign_up => 'Sign up';

  @override
  String get validation_error_email_required => 'Email is required';

  @override
  String get validation_error_email_invalid => 'Email is invalid';

  @override
  String get validation_error_password_required => 'Password is required';

  @override
  String get validation_error_password_min_length =>
      'Password must be at least 6 characters long';

  @override
  String get validation_error_password_invalid =>
      'Password must contain at least one uppercase letter, one lowercase letter, one number and one special character';
}
