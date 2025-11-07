import 'package:get_it/get_it.dart';
import 'package:blockin/app/auth/injections.dart';

GetIt getIt = GetIt.instance;

void startInjectionModules() {
  authModuleInjections();
}
