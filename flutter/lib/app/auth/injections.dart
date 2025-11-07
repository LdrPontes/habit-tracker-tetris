import 'package:blockin/app/auth/data/repositories/supabase_auth_repository.dart';
import 'package:blockin/app/auth/data/services/google_sign_in_service.dart';
import 'package:blockin/app/auth/domain/repositories/auth_repository.dart';
import 'package:blockin/app/auth/ui/blocs/sign_in/sign_in_bloc.dart';
import 'package:blockin/app/auth/ui/blocs/sign_up/sign_up_bloc.dart';
import 'package:blockin/app/auth/ui/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:blockin/app/auth/ui/blocs/reset_password/reset_password_bloc.dart';
import 'package:blockin/core/app_injections.dart';
import 'package:blockin/app/auth/data/services/apple_sign_in_service.dart';

void authModuleInjections() {
  _startBlocsInjections();
  _startRepositoriesInjections();
  _startServicesInjections();
}

void _startBlocsInjections() {
  getIt.registerFactory<SignInBloc>(
    () => SignInBloc(authRepository: getIt<AuthRepository>()),
  );
  getIt.registerFactory<SignUpBloc>(
    () => SignUpBloc(authRepository: getIt<AuthRepository>()),
  );
  getIt.registerFactory<ForgotPasswordBloc>(
    () => ForgotPasswordBloc(authRepository: getIt<AuthRepository>()),
  );
  getIt.registerFactory<ResetPasswordBloc>(
    () => ResetPasswordBloc(authRepository: getIt<AuthRepository>()),
  );
}

void _startRepositoriesInjections() {
  getIt.registerLazySingleton<AuthRepository>(
    () => SupabaseAuthRepository(
      googleSignInService: getIt<GoogleSignInService>(),
      appleSignInService: getIt<AppleSignInService>(),
    ),
  );
}

void _startServicesInjections() {
  getIt.registerLazySingleton<GoogleSignInService>(() => GoogleSignInService());
  getIt.registerLazySingleton<AppleSignInService>(() => AppleSignInService());
}
