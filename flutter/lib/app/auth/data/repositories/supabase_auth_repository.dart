import 'package:starter/app/auth/data/services/apple_sign_in_service.dart';
import 'package:starter/app/auth/data/services/google_sign_in_service.dart';
import 'package:starter/app/auth/domain/dto/sign_in_dto.dart';
import 'package:starter/app/auth/domain/dto/sign_up_dto.dart';
import 'package:starter/app/auth/domain/errors/auth_exception.dart';
import 'package:starter/app/auth/domain/repositories/auth_repository.dart';
import 'package:starter/app/shared/domain/dto/result.dart';
import 'package:starter/app/shared/domain/model/user.dart';
import 'package:starter/interfaces/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

class SupabaseAuthRepository implements AuthRepository {
  final GoogleSignInService _googleSignInService;
  final AppleSignInService _appleSignInService;

  SupabaseAuthRepository({
    required GoogleSignInService googleSignInService,
    required AppleSignInService appleSignInService,
  }) : _googleSignInService = googleSignInService,
       _appleSignInService = appleSignInService;

  @override
  Future<Result<User>> signInWithApple() async {
    try {
      String nonce = Supabase.instance.client.auth.generateRawNonce();
      String idToken = await _appleSignInService.signIn(nonce);

      final response = await Supabase.instance.client.auth.signInWithIdToken(
        provider: OAuthProvider.apple,
        idToken: idToken,
        nonce: nonce,
      );

      return Result.success(
        data: User.fromSupabaseUser(response.user?.toJson() ?? {}),
      );
    } on AuthenticationException catch (e) {
      logger.e(
        '[SupabaseAuthRepository] AuthenticationException: ${e.toString()}',
      );
      return Result.error(exception: e);
    } on AuthException catch (e) {
      logger.e('[SupabaseAuthRepository] AuthException: ${e.toString()}');
      return Result.error(
        exception: AuthenticationException(
          code: AuthenticationExceptionCode.appleSignInFailed,
        ),
      );
    } catch (e) {
      logger.e('[SupabaseAuthRepository] UnknownException: ${e.toString()}');
      return Result.error(
        exception: AuthenticationException(
          code: AuthenticationExceptionCode.unknownError,
        ),
      );
    }
  }

  @override
  Future<Result<User>> signInWithEmail(SignInDto signInDto) {
    throw AuthenticationException(
      code: AuthenticationExceptionCode.unknownError,
    );
  }

  @override
  Future<Result<User>> signInWithGoogle() async {
    try {
      final (idToken, accessToken) = await _googleSignInService.signIn();

      final response = await Supabase.instance.client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      return Result.success(
        data: User.fromSupabaseUser(response.user?.toJson() ?? {}),
      );
    } on AuthenticationException catch (e) {
      logger.e(
        '[SupabaseAuthRepository] AuthenticationException: ${e.toString()}',
      );
      return Result.error(exception: e);
    } on AuthException catch (e) {
      logger.e('[SupabaseAuthRepository] AuthException: ${e.toString()}');
      return Result.error(
        exception: AuthenticationException(
          code: AuthenticationExceptionCode.googleSignInFailed,
        ),
        message: e.message,
        code: e.code,
      );
    } catch (e) {
      logger.e('[SupabaseAuthRepository] UnknownException: ${e.toString()}');
      return Result.error(
        exception: AuthenticationException(
          code: AuthenticationExceptionCode.unknownError,
        ),
        message: e.toString(),
      );
    }
  }

  @override
  Future<Result<User>> signUp(SignUpDto signUpDto) {
    throw AuthenticationException(
      code: AuthenticationExceptionCode.unknownError,
    );
  }
}
