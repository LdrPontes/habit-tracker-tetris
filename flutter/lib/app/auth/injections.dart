import 'package:starter/app/auth/ui/blocs/sign_in/sign_in_bloc.dart';
import 'package:starter/core/app_injections.dart';

void authModuleInjections() {
  getIt.registerLazySingleton<SignInBloc>(() => SignInBloc());
}
