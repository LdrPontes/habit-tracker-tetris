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
  String get auth_error_google_sign_in_failed =>
      'Falha ao entrar com Google. Tente novamente.';

  @override
  String get auth_error_google_id_token_not_found =>
      'Token de ID do Google não encontrado. Tente novamente.';

  @override
  String get auth_error_apple_sign_in_failed =>
      'Falha ao entrar com Apple. Tente novamente.';

  @override
  String get auth_error_unknown_error =>
      'Ocorreu um erro desconhecido. Tente novamente.';

  @override
  String get auth_error_apple_id_token_not_found =>
      'Não foi possível entrar com Apple. Tente novamente.';

  @override
  String get auth_error_user_already_exists =>
      'Um usuário com este email já existe.';

  @override
  String get auth_error_user_not_found =>
      'Usuário não encontrado. Verifique suas credenciais.';

  @override
  String get auth_error_user_invalid_credentials =>
      'Credenciais inválidas. Verifique seu email e senha.';

  @override
  String get auth_error_email_not_confirmed =>
      'Por favor, confirme seu endereço de email antes de entrar.';

  @override
  String get auth_error_same_password =>
      'A nova senha deve ser diferente da sua senha atual.';

  @override
  String get auth_error_email_send_rate_limit =>
      'Por motivos de segurança, você só pode solicitar isso após 1 minuto.';

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
  String get sign_up_title => 'Criar Conta';

  @override
  String get sign_up_with_email => 'Cadastre-se com E-mail';

  @override
  String get sign_in_call_to_action => 'Já tem uma conta?';

  @override
  String get name => 'Nome';

  @override
  String get validation_error_name_required => 'Nome é obrigatório';

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

  @override
  String get confirm_your_email => 'Verifique seu email e confirme sua conta';

  @override
  String get check_your_email_title => 'Verifique seu email';

  @override
  String get check_your_email_description =>
      'Acesse sua caixa de entrada e clique no link\npara verificar seu endereço de email';

  @override
  String get i_didnt_get_an_email => 'Não recebi um email';

  @override
  String resend_email_cooldown(Object seconds) {
    return 'Reenviar email em $seconds segundos';
  }
}
