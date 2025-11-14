part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpWithEmailEvent extends SignUpEvent {
  final SignUpDto signUpDto;

  const SignUpWithEmailEvent({required this.signUpDto});

  @override
  List<Object> get props => [signUpDto];
}

class SignUpWithGoogleEvent extends SignUpEvent {}

class SignUpWithAppleEvent extends SignUpEvent {}

class ResendConfirmationEmailEvent extends SignUpEvent {
  final String email;

  const ResendConfirmationEmailEvent({required this.email});

  @override
  List<Object> get props => [email];
}

class ResendEmailTimerTickEvent extends SignUpEvent {
  const ResendEmailTimerTickEvent();
}
