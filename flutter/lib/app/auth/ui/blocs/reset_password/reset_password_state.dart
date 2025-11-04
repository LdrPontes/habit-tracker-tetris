part of 'reset_password_bloc.dart';

class ResetPasswordState extends Equatable {
  final Result<void> result;

  const ResetPasswordState({this.result = const Idle<void>()});

  ResetPasswordState copyWith({Result<void>? result}) {
    return ResetPasswordState(result: result ?? this.result);
  }

  @override
  List<Object> get props => [result];
}
