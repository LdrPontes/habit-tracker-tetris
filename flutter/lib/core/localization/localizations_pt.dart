// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'blockin';

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
      'Não foi possível entrar com Apple. Tente novamente.';

  @override
  String get authErrorUserAlreadyExists =>
      'Um usuário com este email já existe.';

  @override
  String get authErrorUserNotFound =>
      'Usuário não encontrado. Verifique suas credenciais.';

  @override
  String get authErrorUserInvalidCredentials =>
      'Credenciais inválidas. Verifique seu email e senha.';

  @override
  String get authErrorEmailNotConfirmed =>
      'Por favor, confirme seu endereço de email antes de entrar.';

  @override
  String get authErrorSamePassword =>
      'A nova senha deve ser diferente da sua senha atual.';
}
