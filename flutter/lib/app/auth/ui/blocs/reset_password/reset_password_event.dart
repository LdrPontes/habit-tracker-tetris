part of 'reset_password_bloc.dart';

class ResetPasswordEvent extends Equatable {
  final String newPassword;

  const ResetPasswordEvent({required this.newPassword});

  @override
  List<Object> get props => [newPassword];
}
