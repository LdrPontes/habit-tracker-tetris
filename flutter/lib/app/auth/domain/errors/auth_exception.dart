import 'package:blockin/app/shared/domain/errors/app_exceptions.dart';
import 'package:blockin/core/localization/localizations.dart';

enum AuthenticationExceptionCode {
  googleSignInFailed,
  googleIdTokenNotFound,
  appleSignInFailed,
  appleIdTokenNotFound,
  userAlreadyExists,
  userNotFound,
  invalidCredentials,
  emailNotConfirmed,
  samePassword,
  emailSendRateLimit,
  unknownError,
}

class AuthenticationException implements AppException {
  final AuthenticationExceptionCode? code;
  final String? rawCode;

  const AuthenticationException({
    this.code = AuthenticationExceptionCode.unknownError,
    this.rawCode,
  });

  /// Maps a Supabase error code string to an AuthenticationExceptionCode
  static AuthenticationExceptionCode? _mapSupabaseErrorCode(String? errorCode) {
    if (errorCode == null) return null;

    switch (errorCode) {
      case 'user_already_exists':
        return AuthenticationExceptionCode.userAlreadyExists;
      case 'user_not_found':
        return AuthenticationExceptionCode.userNotFound;
      case 'invalid_credentials':
        return AuthenticationExceptionCode.invalidCredentials;
      case 'email_not_confirmed':
        return AuthenticationExceptionCode.emailNotConfirmed;
      case 'same_password':
        return AuthenticationExceptionCode.samePassword;
      case 'over_email_send_rate_limit':
        return AuthenticationExceptionCode.emailSendRateLimit;
      default:
        return null;
    }
  }

  /// Creates an AuthenticationException from a Supabase error code
  factory AuthenticationException.fromSupabaseError(String? errorCode) {
    final mappedCode = _mapSupabaseErrorCode(errorCode);
    return AuthenticationException(
      code: mappedCode ?? AuthenticationExceptionCode.unknownError,
      rawCode: errorCode,
    );
  }

  @override
  String getLocalizedMessage(AppLocalizations localizations) {
    // First check if we have a mapped code
    switch (code) {
      case AuthenticationExceptionCode.googleSignInFailed:
        return localizations.auth_error_google_sign_in_failed;
      case AuthenticationExceptionCode.googleIdTokenNotFound:
        return localizations.auth_error_google_id_token_not_found;
      case AuthenticationExceptionCode.appleSignInFailed:
        return localizations.auth_error_apple_sign_in_failed;
      case AuthenticationExceptionCode.appleIdTokenNotFound:
        return localizations.auth_error_apple_id_token_not_found;
      case AuthenticationExceptionCode.userAlreadyExists:
        return localizations.auth_error_user_already_exists;
      case AuthenticationExceptionCode.userNotFound:
        return localizations.auth_error_user_not_found;
      case AuthenticationExceptionCode.invalidCredentials:
        return localizations.auth_error_user_invalid_credentials;
      case AuthenticationExceptionCode.emailNotConfirmed:
        return localizations.auth_error_email_not_confirmed;
      case AuthenticationExceptionCode.samePassword:
        return localizations.auth_error_same_password;
      case AuthenticationExceptionCode.emailSendRateLimit:
        return localizations.auth_error_email_send_rate_limit;
      case AuthenticationExceptionCode.unknownError:
      case null:
        // If no mapped code, try to map the raw code
        if (rawCode != null) {
          final mappedCode = _mapSupabaseErrorCode(rawCode);
          if (mappedCode != null) {
            return AuthenticationException(
              code: mappedCode,
              rawCode: rawCode,
            ).getLocalizedMessage(localizations);
          }
        }
        return localizations.auth_error_unknown_error;
    }
  }
}
