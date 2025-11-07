import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blockin/app/auth/domain/repositories/auth_repository.dart';
import 'package:blockin/app/shared/domain/dto/result.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthRepository _authRepository;

  ForgotPasswordBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const ForgotPasswordState()) {
    on<ForgotPasswordEvent>(_onForgotPasswordEvent);
  }

  Future<void> _onForgotPasswordEvent(
    ForgotPasswordEvent event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(state.copyWith(result: const Result.loading()));
    final result = await _authRepository.forgotPassword(event.email);
    emit(state.copyWith(result: result));
  }
}
