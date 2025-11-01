// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'Starter';

  @override
  String get authErrorGoogleSignInFailed =>
      'Falha ao entrar com Google. Tente novamente.';

  @override
  String get authErrorGoogleIdTokenNotFound =>
      'Token de ID do Google não encontrado. Tente novamente.';

  @override
  String get authErrorAppleSignInFailed =>
      'Falha ao entrar com Apple. Tente novamente.';

  @override
  String get authErrorUnknownError =>
      'Ocorreu um erro desconhecido. Tente novamente.';

  @override
  String get authErrorAppleIdTokenNotFound =>
      'Sorry, we couldn\'t sign you in with Apple. Please try again.';
}
