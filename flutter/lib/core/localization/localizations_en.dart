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

  @override
  String get forgot_password_title => 'Forgot Password';

  @override
  String get send_reset_link => 'Send Reset Link';

  @override
  String get reset_password_title => 'Reset Password';

  @override
  String get new_password => 'New Password';

  @override
  String get confirm_password => 'Confirm Password';

  @override
  String get reset_password => 'Reset Password';

  @override
  String get validation_error_password_confirm_required =>
      'Please confirm your password';

  @override
  String get validation_error_passwords_do_not_match =>
      'Passwords do not match';

  @override
  String get password_reset_link_sent =>
      'Password reset link sent to your email';

  @override
  String get password_reset_successfully => 'Password reset successfully';

  @override
  String get start_onboarding => 'Let\'s start!';

  @override
  String get start_onboarding_title =>
      'Welcome aboard! You\'re off to a great start.';

  @override
  String get start_onboarding_description =>
      'Just a few quick questions\nand you\'ll get your first piece!';

  @override
  String get onboarding_first_question => 'What is your goal using Blockin?';

  @override
  String get onboarding_first_question_option_1 => 'Develop new habits';

  @override
  String get onboarding_first_question_option_2 => 'Make the process fun';

  @override
  String get onboarding_first_question_option_3 => 'Document my journey';

  @override
  String get onboarding_first_question_option_4 =>
      'Increase motivation and consistency';

  @override
  String get onboarding_first_question_option_5 => 'Other';

  @override
  String get onboarding_second_question => 'What is your age?';

  @override
  String get onboarding_second_question_option_1 => 'Under 18';

  @override
  String get onboarding_second_question_option_2 => '19 to 24';

  @override
  String get onboarding_second_question_option_3 => '25 to 34';

  @override
  String get onboarding_second_question_option_4 => '35 to 44';

  @override
  String get onboarding_second_question_option_5 => '45 to 54';

  @override
  String get onboarding_second_question_option_6 => '55 to 64';

  @override
  String get onboarding_second_question_option_7 => '65 or older';

  @override
  String get onboarding_third_question => 'How did you hear about us?';

  @override
  String get onboarding_third_question_option_1 => 'Instagram';

  @override
  String get onboarding_third_question_option_2 => 'TikTok';

  @override
  String get onboarding_third_question_option_3 => 'Facebook';

  @override
  String get onboarding_third_question_option_4 => 'YouTube';

  @override
  String get onboarding_third_question_option_5 => 'Friends and/or family';

  @override
  String get onboarding_third_question_option_6 => 'Influencers';

  @override
  String get onboarding_third_question_option_7 => 'Other';

  @override
  String get onboarding_fourth_question =>
      'Have you tried other habit tracker apps?';

  @override
  String get onboarding_fourth_question_option_1 => 'Yes';

  @override
  String get onboarding_fourth_question_option_2 => 'No';

  @override
  String get onboarding_notification_title =>
      'Keep consistency, activate our reminders';

  @override
  String get continue_button => 'Continue';

  @override
  String get blockin_daily_habits => 'Blockin: Daily Habits';

  @override
  String get only_two_more_goals => 'Only two more goals for today!';

  @override
  String get only_three_more_goals =>
      'Only three more pieces to reach your next goal!';

  @override
  String get onboarding_finished_title =>
      'All set! Let\'s place your first block to celebrate';
}
