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
        return localizations.authErrorGoogleSignInFailed;
      case AuthenticationExceptionCode.googleIdTokenNotFound:
        return localizations.authErrorGoogleIdTokenNotFound;
      case AuthenticationExceptionCode.appleSignInFailed:
        return localizations.authErrorAppleSignInFailed;
      case AuthenticationExceptionCode.appleIdTokenNotFound:
        return localizations.authErrorAppleIdTokenNotFound;
      case AuthenticationExceptionCode.userAlreadyExists:
        return localizations.authErrorUserAlreadyExists;
      case AuthenticationExceptionCode.userNotFound:
        return localizations.authErrorUserNotFound;
      case AuthenticationExceptionCode.invalidCredentials:
        return localizations.authErrorUserInvalidCredentials;
      case AuthenticationExceptionCode.emailNotConfirmed:
        return localizations.authErrorEmailNotConfirmed;
      case AuthenticationExceptionCode.samePassword:
        return localizations.authErrorSamePassword;
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
        return localizations.authErrorUnknownError;
    }
  }
}
