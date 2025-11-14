part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  final Result<User> userResult;
  final Result<void> resendEmailResult;
  final int resendEmailCooldownSeconds;

  const SignUpState({
    this.userResult = const Idle<User>(),
    this.resendEmailResult = const Idle<void>(),
    this.resendEmailCooldownSeconds = 0,
  });

  SignUpState copyWith({
    Result<User>? userResult,
    Result<void>? resendEmailResult,
    int? resendEmailCooldownSeconds,
  }) {
    return SignUpState(
      userResult: userResult ?? this.userResult,
      resendEmailResult: resendEmailResult ?? this.resendEmailResult,
      resendEmailCooldownSeconds:
          resendEmailCooldownSeconds ?? this.resendEmailCooldownSeconds,
    );
  }

  @override
  List<Object> get props => [
    userResult,
    resendEmailResult,
    resendEmailCooldownSeconds,
  ];
}
