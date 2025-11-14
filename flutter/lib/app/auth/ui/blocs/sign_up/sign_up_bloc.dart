import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blockin/app/auth/domain/dto/sign_up_dto.dart';
import 'package:blockin/app/shared/domain/dto/result.dart';
import 'package:blockin/app/auth/domain/repositories/auth_repository.dart';
import 'package:blockin/app/shared/domain/model/user.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository _authRepository;
  Timer? _resendEmailTimer;

  SignUpBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const SignUpState()) {
    on<SignUpWithEmailEvent>(_onSignUpWithEmailEvent);
    on<SignUpWithGoogleEvent>(_onSignUpWithGoogleEvent);
    on<SignUpWithAppleEvent>(_onSignUpWithAppleEvent);
    on<ResendConfirmationEmailEvent>(_onResendConfirmationEmailEvent);
    on<ResendEmailTimerTickEvent>(_onResendEmailTimerTickEvent);
  }

  @override
  Future<void> close() {
    _resendEmailTimer?.cancel();
    return super.close();
  }

  Future<void> _onSignUpWithEmailEvent(
    SignUpWithEmailEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(userResult: const Result.loading()));
    final result = await _authRepository.signUp(event.signUpDto);
    emit(state.copyWith(userResult: result));
  }

  Future<void> _onSignUpWithGoogleEvent(
    SignUpWithGoogleEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(userResult: const Result.loading()));
    final result = await _authRepository.signInWithGoogle();
    emit(state.copyWith(userResult: result));
  }

  Future<void> _onSignUpWithAppleEvent(
    SignUpWithAppleEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(userResult: const Result.loading()));
    final result = await _authRepository.signInWithApple();
    emit(state.copyWith(userResult: result));
  }

  Future<void> _onResendConfirmationEmailEvent(
    ResendConfirmationEmailEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(resendEmailResult: const Result.loading()));
    final result = await _authRepository.resendConfirmationEmail(event.email);

    if (result is Success) {
      // Start 1 minute (60 seconds) cooldown timer
      emit(
        state.copyWith(
          resendEmailResult: result,
          resendEmailCooldownSeconds: 60,
        ),
      );

      _resendEmailTimer?.cancel();
      _resendEmailTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        add(const ResendEmailTimerTickEvent());
      });
    } else {
      emit(state.copyWith(resendEmailResult: result));
    }
  }

  void _onResendEmailTimerTickEvent(
    ResendEmailTimerTickEvent event,
    Emitter<SignUpState> emit,
  ) {
    if (state.resendEmailCooldownSeconds > 0) {
      emit(
        state.copyWith(
          resendEmailCooldownSeconds: state.resendEmailCooldownSeconds - 1,
        ),
      );
    } else {
      _resendEmailTimer?.cancel();
      _resendEmailTimer = null;
    }
  }
}
