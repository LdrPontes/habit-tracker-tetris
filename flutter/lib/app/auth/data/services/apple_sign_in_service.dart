import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:starter/app/auth/domain/errors/auth_exception.dart';
import 'package:starter/interfaces/logger.dart';

class AppleSignInService {
  Future<
    (String idToken, String? fullName, String? givenName, String? familyName)
  >
  signIn(String nonce) async {
    try {
      final hashedNonce = sha256.convert(utf8.encode(nonce)).toString();
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: hashedNonce,
      );

      final idToken = credential.identityToken;
      if (idToken == null) {
        logger.e('[AppleSignInService] idToken is null');
        throw AuthenticationException(
          code: AuthenticationExceptionCode.appleIdTokenNotFound,
        );
      }

      String? fullName = '${credential.givenName} ${credential.familyName}';
      String? givenName = credential.givenName;
      String? familyName = credential.familyName;

      return (idToken, fullName, givenName, familyName);
    } catch (e) {
      logger.e('[AppleSignInService] UnknownException: ${e.toString()}');
      throw AuthenticationException(
        code: AuthenticationExceptionCode.appleSignInFailed,
      );
    }
  }
}
