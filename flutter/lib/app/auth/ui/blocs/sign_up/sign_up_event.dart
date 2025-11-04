part of 'sign_up_bloc.dart';

class SignUpEvent extends Equatable {
  final SignUpDto signUpDto;

  const SignUpEvent({required this.signUpDto});

  @override
  List<Object> get props => [signUpDto];
}
