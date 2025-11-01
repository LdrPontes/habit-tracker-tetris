import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/app/auth/domain/repositories/auth_repository.dart';
import 'package:starter/app/shared/domain/dto/result.dart';
import 'package:starter/app/shared/domain/model/user.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository _authRepository;

  SignInBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const SignInState()) {
    on<SignInWithGoogleEvent>(_onSignInWithGoogleEvent);
    on<SignInWithAppleEvent>(_onSignInWithAppleEvent);
    on<SignInWithEmailEvent>(_onSignInWithEmailEvent);
  }

  Future<void> _onSignInWithGoogleEvent(
    SignInWithGoogleEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(userResult: const Result.loading()));
    final result = await _authRepository.signInWithGoogle();
    emit(state.copyWith(userResult: result));
  }

  Future<void> _onSignInWithAppleEvent(
    SignInWithAppleEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(userResult: const Result.loading()));
    final result = await _authRepository.signInWithApple();
    emit(state.copyWith(userResult: result));
  }

  Future<void> _onSignInWithEmailEvent(
    SignInWithEmailEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(userResult: const Result.loading()));
  }
}
