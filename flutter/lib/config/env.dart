import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'SUPABASE_URL', obfuscate: true)
  static String SUPABASE_URL = _Env.SUPABASE_URL;

  @EnviedField(varName: 'SUPABASE_ANON_KEY', obfuscate: true)
  static String SUPABASE_ANON_KEY = _Env.SUPABASE_ANON_KEY;

  @EnviedField(varName: 'REDIRECT_URL', obfuscate: true)
  static String REDIRECT_URL = _Env.REDIRECT_URL;
}
