import 'package:google_sign_in/google_sign_in.dart';
import 'package:starter/app/auth/domain/errors/auth_exception.dart';
import 'package:starter/interfaces/logger.dart';

class GoogleSignInService {
  Future<(String idToken, String accessToken)> signIn() async {
    try {
      final googleUser = await GoogleSignIn.instance.authenticate(
        scopeHint: ['email', 'profile'],
      );

      final authorization =
          await googleUser.authorizationClient.authorizationForScopes([
            'email',
            'profile',
          ]) ??
          await googleUser.authorizationClient.authorizeScopes([
            'email',
            'profile',
          ]);

      final idToken = googleUser.authentication.idToken;
      if (idToken == null) {
        logger.e('[GoogleSignInService] idToken is null');
        throw AuthenticationException(
          code: AuthenticationExceptionCode.googleIdTokenNotFound,
        );
      }

      return (idToken, authorization.accessToken);
    } catch (e) {
      logger.e('[GoogleSignInService] error: ${e.toString()}');
      throw AuthenticationException(
        code: AuthenticationExceptionCode.googleSignInFailed,
      );
    }
  }
}
