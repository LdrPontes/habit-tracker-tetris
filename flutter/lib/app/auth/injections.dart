import 'package:starter/app/auth/data/repositories/supabase_auth_repository.dart';
import 'package:starter/app/auth/data/services/google_sign_in_service.dart';
import 'package:starter/app/auth/domain/repositories/auth_repository.dart';
import 'package:starter/app/auth/ui/blocs/sign_in/sign_in_bloc.dart';
import 'package:starter/core/app_injections.dart';
import 'package:starter/app/auth/data/services/apple_sign_in_service.dart';

void authModuleInjections() {
  _startBlocsInjections();
  _startRepositoriesInjections();
  _startServicesInjections();
}

void _startBlocsInjections() {
  getIt.registerLazySingleton<SignInBloc>(
    () => SignInBloc(authRepository: getIt<AuthRepository>()),
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
