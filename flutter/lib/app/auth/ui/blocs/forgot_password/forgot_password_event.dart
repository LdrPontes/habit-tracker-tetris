part of 'forgot_password_bloc.dart';

class ForgotPasswordEvent extends Equatable {
  final String email;

  const ForgotPasswordEvent({required this.email});

  @override
  List<Object> get props => [email];
}
