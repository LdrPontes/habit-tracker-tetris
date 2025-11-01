part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  final Result<User> userResult;

  const SignInState({this.userResult = const Idle<User>()});

  SignInState copyWith({Result<User>? userResult}) {
    return SignInState(userResult: userResult ?? this.userResult);
  }

  @override
  List<Object> get props => [userResult];
}
