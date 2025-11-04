part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  final Result<User> userResult;

  const SignUpState({this.userResult = const Idle<User>()});

  SignUpState copyWith({Result<User>? userResult}) {
    return SignUpState(userResult: userResult ?? this.userResult);
  }

  @override
  List<Object> get props => [userResult];
}
