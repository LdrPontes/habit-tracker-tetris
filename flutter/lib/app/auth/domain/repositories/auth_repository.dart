import 'package:starter/app/auth/domain/dto/sign_in_dto.dart';
import 'package:starter/app/auth/domain/dto/sign_up_dto.dart';
import 'package:starter/app/shared/domain/dto/result.dart';
import 'package:starter/app/shared/domain/model/user.dart';

abstract interface class AuthRepository {
  Future<Result<User>> signInWithGoogle();
  Future<Result<User>> signInWithApple();
  Future<Result<User>> signInWithEmail(SignInDto signInDto);
  Future<Result<User>> signUp(SignUpDto signUpDto);
  Future<Result> signOut();
  Future<User?> getCurrentUser();
  Future<Result<void>> forgotPassword(String email);
  Future<Result<void>> resetPassword(String newPassword);
}
