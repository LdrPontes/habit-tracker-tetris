import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/app/auth/domain/repositories/auth_repository.dart';
import 'package:starter/app/shared/domain/dto/result.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final AuthRepository _authRepository;

  ResetPasswordBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const ResetPasswordState()) {
    on<ResetPasswordEvent>(_onResetPasswordEvent);
  }

  Future<void> _onResetPasswordEvent(
    ResetPasswordEvent event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(state.copyWith(result: const Result.loading()));
    final result = await _authRepository.resetPassword(event.newPassword);
    emit(state.copyWith(result: result));
  }
}
