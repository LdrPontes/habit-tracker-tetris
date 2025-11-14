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

  @override
  String get welcome_description =>
      'Registre sua jornada\nde uma forma visual\ne divertida';

  @override
  String get start_button => 'Começar';

  @override
  String get back => 'Voltar';

  @override
  String get sign_in_title => 'Iniciar Sessão';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Senha';

  @override
  String get sign_in => 'Entrar';

  @override
  String get forgot_password => 'Esqueceu sua senha?';

  @override
  String get or => 'ou';

  @override
  String get continue_with_google => 'Entrar com Google';

  @override
  String get continue_with_apple => 'Entrar com Apple';

  @override
  String get sign_up_call_to_action => 'Ainda não tem uma conta?';

  @override
  String get sign_up => 'Cadastre-se';

  @override
  String get validation_error_email_required => 'Email é obrigatório';

  @override
  String get validation_error_email_invalid => 'Email é inválido';

  @override
  String get validation_error_password_required => 'Senha é obrigatória';

  @override
  String get validation_error_password_min_length =>
      'Senha deve ter pelo menos 6 caracteres';

  @override
  String get validation_error_password_invalid =>
      'Senha deve conter pelo menos uma letra maiúscula, uma letra minúscula, um número e um caractere especial';
}
