import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/app/auth/domain/dto/sign_up_dto.dart';
import 'package:starter/app/shared/domain/dto/result.dart';
import 'package:starter/app/auth/domain/repositories/auth_repository.dart';
import 'package:starter/app/shared/domain/model/user.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository _authRepository;

  SignUpBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const SignUpState()) {
    on<SignUpEvent>(_onSignUpEvent);
  }

  Future<void> _onSignUpEvent(
    SignUpEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(userResult: const Result.loading()));
    final result = await _authRepository.signUp(event.signUpDto);
    emit(state.copyWith(userResult: result));
  }
}
