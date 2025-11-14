import 'package:blockin/app/auth/data/services/apple_sign_in_service.dart';
import 'package:blockin/app/auth/data/services/google_sign_in_service.dart';
import 'package:blockin/app/auth/domain/dto/sign_in_dto.dart';
import 'package:blockin/app/auth/domain/dto/sign_up_dto.dart';
import 'package:blockin/app/auth/domain/errors/auth_exception.dart';
import 'package:blockin/app/auth/domain/repositories/auth_repository.dart';
import 'package:blockin/app/shared/domain/dto/result.dart';
import 'package:blockin/app/shared/domain/model/user.dart';
import 'package:blockin/config/env.dart';
import 'package:blockin/interfaces/logger.dart';
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
      final (idToken, fullName, givenName, familyName) =
          await _appleSignInService.signIn(nonce);

      final response = await Supabase.instance.client.auth.signInWithIdToken(
        provider: OAuthProvider.apple,
        idToken: idToken,
        nonce: nonce,
      );

      // If the user has a given name or family name, update the user's metadata because Apple just provides it in the first login.
      if (givenName != null || familyName != null) {
        final updatedUser = await Supabase.instance.client.auth.updateUser(
          UserAttributes(
            data: {
              'full_name': fullName,
              'given_name': givenName,
              'family_name': familyName,
            },
          ),
        );

        return Result.success(
          data: User.fromSupabaseUser(updatedUser.user?.toJson() ?? {}),
        );
      }

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
        exception: AuthenticationException.fromSupabaseError(e.code),
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
  Future<Result<User>> signInWithEmail(SignInDto signInDto) async {
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: signInDto.email,
        password: signInDto.password,
      );

      return Result.success(
        data: User.fromSupabaseUser(response.user?.toJson() ?? {}),
      );
    } on AuthException catch (e) {
      logger.e('[SupabaseAuthRepository] AuthException: ${e.toString()}');
      return Result.error(
        exception: AuthenticationException.fromSupabaseError(e.code),
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
        exception: AuthenticationException.fromSupabaseError(e.code),
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
  Future<Result<User>> signUp(SignUpDto signUpDto) async {
    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: signUpDto.email!,
        password: signUpDto.password!,
        data: {'full_name': signUpDto.fullName!},
        emailRedirectTo: Env.REDIRECT_URL,
      );

      return Result.success(
        data: User.fromSupabaseUser(response.user?.toJson() ?? {}),
      );
    } on AuthException catch (e) {
      logger.e('[SupabaseAuthRepository] AuthException: ${e.toString()}');
      return Result.error(
        exception: AuthenticationException.fromSupabaseError(e.code),
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
  Future<Result<void>> forgotPassword(String email) async {
    try {
      await Supabase.instance.client.auth.resetPasswordForEmail(
        email,
        redirectTo: '${Env.REDIRECT_URL}reset-password',
      );

      return const Result.success();
    } on AuthException catch (e) {
      return Result.error(
        exception: AuthenticationException.fromSupabaseError(e.code),
      );
    } catch (e) {
      return Result.error(
        exception: AuthenticationException(
          code: AuthenticationExceptionCode.unknownError,
        ),
      );
    }
  }

  @override
  Future<Result<void>> resetPassword(String newPassword) async {
    try {
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(password: newPassword),
      );

      await Supabase.instance.client.auth.signOut();

      return const Result.success();
    } on AuthException catch (e) {
      return Result.error(
        exception: AuthenticationException.fromSupabaseError(e.code),
      );
    } catch (e) {
      return Result.error(
        exception: AuthenticationException(
          code: AuthenticationExceptionCode.unknownError,
        ),
      );
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    final user = Supabase.instance.client.auth.currentUser;
    return user != null ? User.fromSupabaseUser(user.toJson()) : null;
  }

  @override
  Future<Result> signOut() async {
    try {
      await Supabase.instance.client.auth.signOut();
      return const Result.success();
    } on AuthException catch (e) {
      logger.e('[SupabaseAuthRepository] AuthException: ${e.toString()}');
      return Result.error(
        exception: AuthenticationException.fromSupabaseError(e.code),
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
}
