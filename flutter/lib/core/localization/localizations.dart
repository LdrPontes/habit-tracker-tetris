import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations_en.dart';
import 'localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'blockin'**
  String get appName;

  /// No description provided for @auth_error_google_sign_in_failed.
  ///
  /// In en, this message translates to:
  /// **'Google sign in failed. Please try again.'**
  String get auth_error_google_sign_in_failed;

  /// No description provided for @auth_error_google_id_token_not_found.
  ///
  /// In en, this message translates to:
  /// **'Sorry, we couldn\'t sign you in with Google. Please try again.'**
  String get auth_error_google_id_token_not_found;

  /// No description provided for @auth_error_apple_sign_in_failed.
  ///
  /// In en, this message translates to:
  /// **'Apple sign in failed. Please try again.'**
  String get auth_error_apple_sign_in_failed;

  /// No description provided for @auth_error_unknown_error.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred. Please try again.'**
  String get auth_error_unknown_error;

  /// No description provided for @auth_error_apple_id_token_not_found.
  ///
  /// In en, this message translates to:
  /// **'Sorry, we couldn\'t sign you in with Apple. Please try again.'**
  String get auth_error_apple_id_token_not_found;

  /// No description provided for @auth_error_user_already_exists.
  ///
  /// In en, this message translates to:
  /// **'A user with this email already exists.'**
  String get auth_error_user_already_exists;

  /// No description provided for @auth_error_user_not_found.
  ///
  /// In en, this message translates to:
  /// **'User not found. Please check your credentials.'**
  String get auth_error_user_not_found;

  /// No description provided for @auth_error_user_invalid_credentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials. Please check your email and password.'**
  String get auth_error_user_invalid_credentials;

  /// No description provided for @auth_error_email_not_confirmed.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your email address before signing in.'**
  String get auth_error_email_not_confirmed;

  /// No description provided for @auth_error_same_password.
  ///
  /// In en, this message translates to:
  /// **'New password must be different from your current password.'**
  String get auth_error_same_password;

  /// No description provided for @auth_error_email_send_rate_limit.
  ///
  /// In en, this message translates to:
  /// **'For security purposes, you can only request this after 1 minute.'**
  String get auth_error_email_send_rate_limit;

  /// No description provided for @welcome_description.
  ///
  /// In en, this message translates to:
  /// **'Register your journey\nin a visual and\nfun way'**
  String get welcome_description;

  /// No description provided for @start_button.
  ///
  /// In en, this message translates to:
  /// **'Let\'s start'**
  String get start_button;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @sign_in_title.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get sign_in_title;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get sign_in;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgot_password;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @continue_with_google.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continue_with_google;

  /// No description provided for @continue_with_apple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continue_with_apple;

  /// No description provided for @sign_up_call_to_action.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get sign_up_call_to_action;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get sign_up;

  /// No description provided for @sign_up_title.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get sign_up_title;

  /// No description provided for @sign_up_with_email.
  ///
  /// In en, this message translates to:
  /// **'Sign up with Email'**
  String get sign_up_with_email;

  /// No description provided for @sign_in_call_to_action.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get sign_in_call_to_action;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @validation_error_name_required.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get validation_error_name_required;

  /// No description provided for @validation_error_email_required.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get validation_error_email_required;

  /// No description provided for @validation_error_email_invalid.
  ///
  /// In en, this message translates to:
  /// **'Email is invalid'**
  String get validation_error_email_invalid;

  /// No description provided for @validation_error_password_required.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get validation_error_password_required;

  /// No description provided for @validation_error_password_min_length.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters long'**
  String get validation_error_password_min_length;

  /// No description provided for @validation_error_password_invalid.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one uppercase letter, one lowercase letter, one number and one special character'**
  String get validation_error_password_invalid;

  /// No description provided for @confirm_your_email.
  ///
  /// In en, this message translates to:
  /// **'Check your email and confirm your account'**
  String get confirm_your_email;

  /// No description provided for @check_your_email_title.
  ///
  /// In en, this message translates to:
  /// **'Check your email'**
  String get check_your_email_title;

  /// No description provided for @check_your_email_description.
  ///
  /// In en, this message translates to:
  /// **'Visit your inbox and click the link to\nverify your email address'**
  String get check_your_email_description;

  /// No description provided for @i_didnt_get_an_email.
  ///
  /// In en, this message translates to:
  /// **'I didn\'t get an email'**
  String get i_didnt_get_an_email;

  /// No description provided for @resend_email_cooldown.
  ///
  /// In en, this message translates to:
  /// **'Resend email in {seconds} seconds'**
  String resend_email_cooldown(Object seconds);

  /// No description provided for @create_account.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get create_account;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @forgot_password_title.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgot_password_title;

  /// No description provided for @send_reset_link.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get send_reset_link;

  /// No description provided for @reset_password_title.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset_password_title;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get new_password;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// No description provided for @reset_password.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset_password;

  /// No description provided for @validation_error_password_confirm_required.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get validation_error_password_confirm_required;

  /// No description provided for @validation_error_passwords_do_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get validation_error_passwords_do_not_match;

  /// No description provided for @password_reset_link_sent.
  ///
  /// In en, this message translates to:
  /// **'Password reset link sent to your email'**
  String get password_reset_link_sent;

  /// No description provided for @password_reset_successfully.
  ///
  /// In en, this message translates to:
  /// **'Password reset successfully'**
  String get password_reset_successfully;

  /// No description provided for @start_onboarding.
  ///
  /// In en, this message translates to:
  /// **'Let\'s start!'**
  String get start_onboarding;

  /// No description provided for @start_onboarding_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome aboard! You\'re off to a great start.'**
  String get start_onboarding_title;

  /// No description provided for @start_onboarding_description.
  ///
  /// In en, this message translates to:
  /// **'Just a few quick questions\nand you\'ll get your first piece!'**
  String get start_onboarding_description;

  /// No description provided for @onboarding_first_question.
  ///
  /// In en, this message translates to:
  /// **'What is your goal using Blockin?'**
  String get onboarding_first_question;

  /// No description provided for @onboarding_first_question_option_1.
  ///
  /// In en, this message translates to:
  /// **'Develop new habits'**
  String get onboarding_first_question_option_1;

  /// No description provided for @onboarding_first_question_option_2.
  ///
  /// In en, this message translates to:
  /// **'Make the process fun'**
  String get onboarding_first_question_option_2;

  /// No description provided for @onboarding_first_question_option_3.
  ///
  /// In en, this message translates to:
  /// **'Document my journey'**
  String get onboarding_first_question_option_3;

  /// No description provided for @onboarding_first_question_option_4.
  ///
  /// In en, this message translates to:
  /// **'Increase motivation and consistency'**
  String get onboarding_first_question_option_4;

  /// No description provided for @onboarding_first_question_option_5.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get onboarding_first_question_option_5;

  /// No description provided for @onboarding_second_question.
  ///
  /// In en, this message translates to:
  /// **'What is your age?'**
  String get onboarding_second_question;

  /// No description provided for @onboarding_second_question_option_1.
  ///
  /// In en, this message translates to:
  /// **'Under 18'**
  String get onboarding_second_question_option_1;

  /// No description provided for @onboarding_second_question_option_2.
  ///
  /// In en, this message translates to:
  /// **'19 to 24'**
  String get onboarding_second_question_option_2;

  /// No description provided for @onboarding_second_question_option_3.
  ///
  /// In en, this message translates to:
  /// **'25 to 34'**
  String get onboarding_second_question_option_3;

  /// No description provided for @onboarding_second_question_option_4.
  ///
  /// In en, this message translates to:
  /// **'35 to 44'**
  String get onboarding_second_question_option_4;

  /// No description provided for @onboarding_second_question_option_5.
  ///
  /// In en, this message translates to:
  /// **'45 to 54'**
  String get onboarding_second_question_option_5;

  /// No description provided for @onboarding_second_question_option_6.
  ///
  /// In en, this message translates to:
  /// **'55 to 64'**
  String get onboarding_second_question_option_6;

  /// No description provided for @onboarding_second_question_option_7.
  ///
  /// In en, this message translates to:
  /// **'65 or older'**
  String get onboarding_second_question_option_7;

  /// No description provided for @onboarding_third_question.
  ///
  /// In en, this message translates to:
  /// **'How did you hear about us?'**
  String get onboarding_third_question;

  /// No description provided for @onboarding_third_question_option_1.
  ///
  /// In en, this message translates to:
  /// **'Instagram'**
  String get onboarding_third_question_option_1;

  /// No description provided for @onboarding_third_question_option_2.
  ///
  /// In en, this message translates to:
  /// **'TikTok'**
  String get onboarding_third_question_option_2;

  /// No description provided for @onboarding_third_question_option_3.
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get onboarding_third_question_option_3;

  /// No description provided for @onboarding_third_question_option_4.
  ///
  /// In en, this message translates to:
  /// **'YouTube'**
  String get onboarding_third_question_option_4;

  /// No description provided for @onboarding_third_question_option_5.
  ///
  /// In en, this message translates to:
  /// **'Friends and/or family'**
  String get onboarding_third_question_option_5;

  /// No description provided for @onboarding_third_question_option_6.
  ///
  /// In en, this message translates to:
  /// **'Influencers'**
  String get onboarding_third_question_option_6;

  /// No description provided for @onboarding_third_question_option_7.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get onboarding_third_question_option_7;

  /// No description provided for @onboarding_fourth_question.
  ///
  /// In en, this message translates to:
  /// **'Have you tried other habit tracker apps?'**
  String get onboarding_fourth_question;

  /// No description provided for @onboarding_fourth_question_option_1.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get onboarding_fourth_question_option_1;

  /// No description provided for @onboarding_fourth_question_option_2.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get onboarding_fourth_question_option_2;

  /// No description provided for @onboarding_notification_title.
  ///
  /// In en, this message translates to:
  /// **'Keep consistency, activate our reminders'**
  String get onboarding_notification_title;

  /// No description provided for @continue_button.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_button;

  /// No description provided for @blockin_daily_habits.
  ///
  /// In en, this message translates to:
  /// **'Blockin: Daily Habits'**
  String get blockin_daily_habits;

  /// No description provided for @only_two_more_goals.
  ///
  /// In en, this message translates to:
  /// **'Only two more goals for today!'**
  String get only_two_more_goals;

  /// No description provided for @only_three_more_goals.
  ///
  /// In en, this message translates to:
  /// **'Only three more pieces to reach your next goal!'**
  String get only_three_more_goals;

  /// No description provided for @onboarding_finished_title.
  ///
  /// In en, this message translates to:
  /// **'All set! Let\'s place your first block to celebrate'**
  String get onboarding_finished_title;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
