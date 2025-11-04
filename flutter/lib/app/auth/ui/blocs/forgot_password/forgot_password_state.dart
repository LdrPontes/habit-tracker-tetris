part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable {
  final Result<void> result;

  const ForgotPasswordState({this.result = const Idle<void>()});

  ForgotPasswordState copyWith({Result<void>? result}) {
    return ForgotPasswordState(result: result ?? this.result);
  }

  @override
  List<Object> get props => [result];
}
