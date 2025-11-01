import 'package:starter/app/shared/domain/errors/app_exceptions.dart';
import 'package:starter/core/localization/localizations.dart';

enum AuthenticationExceptionCode {
  googleSignInFailed,
  googleIdTokenNotFound,
  appleSignInFailed,
  appleIdTokenNotFound,
  unknownError,
}

class AuthenticationException implements AppException {
  final AuthenticationExceptionCode? code;

  const AuthenticationException({
    this.code = AuthenticationExceptionCode.unknownError,
  });

  @override
  String getLocalizedMessage(AppLocalizations localizations) {
    switch (code) {
      case AuthenticationExceptionCode.googleSignInFailed:
        return localizations.authErrorGoogleSignInFailed;
      case AuthenticationExceptionCode.googleIdTokenNotFound:
        return localizations.authErrorGoogleIdTokenNotFound;
      case AuthenticationExceptionCode.appleSignInFailed:
        return localizations.authErrorAppleSignInFailed;
      case AuthenticationExceptionCode.appleIdTokenNotFound:
        return localizations.authErrorAppleIdTokenNotFound;
      case AuthenticationExceptionCode.unknownError:
      case null:
        return localizations.authErrorUnknownError;
    }
  }
}
