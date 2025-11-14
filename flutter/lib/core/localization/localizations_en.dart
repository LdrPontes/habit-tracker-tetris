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
  String get auth_error_google_sign_in_failed =>
      'Google sign in failed. Please try again.';

  @override
  String get auth_error_google_id_token_not_found =>
      'Sorry, we couldn\'t sign you in with Google. Please try again.';

  @override
  String get auth_error_apple_sign_in_failed =>
      'Apple sign in failed. Please try again.';

  @override
  String get auth_error_unknown_error =>
      'An unknown error occurred. Please try again.';

  @override
  String get auth_error_apple_id_token_not_found =>
      'Sorry, we couldn\'t sign you in with Apple. Please try again.';

  @override
  String get auth_error_user_already_exists =>
      'A user with this email already exists.';

  @override
  String get auth_error_user_not_found =>
      'User not found. Please check your credentials.';

  @override
  String get auth_error_user_invalid_credentials =>
      'Invalid credentials. Please check your email and password.';

  @override
  String get auth_error_email_not_confirmed =>
      'Please confirm your email address before signing in.';

  @override
  String get auth_error_same_password =>
      'New password must be different from your current password.';

  @override
  String get auth_error_email_send_rate_limit =>
      'For security purposes, you can only request this after 1 minute.';

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
  String get sign_up_title => 'Create Account';

  @override
  String get sign_up_with_email => 'Sign up with Email';

  @override
  String get sign_in_call_to_action => 'Already have an account?';

  @override
  String get name => 'Name';

  @override
  String get validation_error_name_required => 'Name is required';

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

  @override
  String get confirm_your_email => 'Check your email and confirm your account';

  @override
  String get check_your_email_title => 'Check your email';

  @override
  String get check_your_email_description =>
      'Visit your inbox and click the link to\nverify your email address';

  @override
  String get i_didnt_get_an_email => 'I didn\'t get an email';

  @override
  String resend_email_cooldown(Object seconds) {
    return 'Resend email in $seconds seconds';
  }

  @override
  String get create_account => 'Create an account';

  @override
  String get login => 'Login';
}
