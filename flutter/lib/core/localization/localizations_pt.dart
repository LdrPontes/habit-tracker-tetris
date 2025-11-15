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

  @override
  String get create_account => 'Criar conta';

  @override
  String get login => 'Login';

  @override
  String get forgot_password_title => 'Esqueceu a Senha';

  @override
  String get send_reset_link => 'Enviar Link de Redefinição';

  @override
  String get reset_password_title => 'Redefinir Senha';

  @override
  String get new_password => 'Nova Senha';

  @override
  String get confirm_password => 'Confirmar Senha';

  @override
  String get reset_password => 'Redefinir Senha';

  @override
  String get validation_error_password_confirm_required =>
      'Por favor, confirme sua senha';

  @override
  String get validation_error_passwords_do_not_match =>
      'As senhas não coincidem';

  @override
  String get password_reset_link_sent =>
      'Link de redefinição de senha enviado para seu email';

  @override
  String get password_reset_successfully => 'Senha redefinida com sucesso';

  @override
  String get start_onboarding => 'Vamos começar!';

  @override
  String get start_onboarding_title => 'Que bom que você chegou! Tá voando.';

  @override
  String get start_onboarding_description =>
      'Responda algumas perguntas\npara receber sua primeira peça!';

  @override
  String get onboarding_first_question =>
      'Qual o seu objetivo usando o Blockin?';

  @override
  String get onboarding_first_question_option_1 => 'Desenvolver novos hábitos';

  @override
  String get onboarding_first_question_option_2 =>
      'Tornar o processo divertido';

  @override
  String get onboarding_first_question_option_3 => 'Documentar minha jornada';

  @override
  String get onboarding_first_question_option_4 =>
      'Aumentar a motivação e consistência';

  @override
  String get onboarding_first_question_option_5 => 'Outro';

  @override
  String get onboarding_second_question => 'Qual é a sua idade?';

  @override
  String get onboarding_second_question_option_1 => 'Até 18 anos';

  @override
  String get onboarding_second_question_option_2 => '19 a 24 anos';

  @override
  String get onboarding_second_question_option_3 => '25 a 34 anos';

  @override
  String get onboarding_second_question_option_4 => '35 a 44 anos';

  @override
  String get onboarding_second_question_option_5 => '45 a 54 anos';

  @override
  String get onboarding_second_question_option_6 => '55 a 64 anos';

  @override
  String get onboarding_second_question_option_7 => '65 anos ou mais';

  @override
  String get onboarding_third_question => 'Como você nos conheceu?';

  @override
  String get onboarding_third_question_option_1 => 'Instagram';

  @override
  String get onboarding_third_question_option_2 => 'TikTok';

  @override
  String get onboarding_third_question_option_3 => 'Facebook';

  @override
  String get onboarding_third_question_option_4 => 'YouTube';

  @override
  String get onboarding_third_question_option_5 => 'Amigos e/ou familiares';

  @override
  String get onboarding_third_question_option_6 => 'Influenciadores';

  @override
  String get onboarding_third_question_option_7 => 'Outros';

  @override
  String get onboarding_fourth_question =>
      'Você já testou outros apps de gestão de hábitos?';

  @override
  String get onboarding_fourth_question_option_1 => 'Sim';

  @override
  String get onboarding_fourth_question_option_2 => 'Não';

  @override
  String get onboarding_notification_title =>
      'Mantenha a consistência, ative nossos lembretes';

  @override
  String get continue_button => 'Continuar';

  @override
  String get blockin_daily_habits => 'Blockin: Hábitos Diários';

  @override
  String get only_two_more_goals => 'Só mais 02 objetivos para hoje!';

  @override
  String get only_three_more_goals =>
      'Faltam apenas três peças para você atingir seu próximo objetivo!';

  @override
  String get onboarding_finished_title =>
      'Tudo pronto! Vamos colocar seu primeiro bloco para comemorar';
}
