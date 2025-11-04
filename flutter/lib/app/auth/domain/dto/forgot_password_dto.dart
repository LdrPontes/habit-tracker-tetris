class ForgotPasswordDto {
  String? email;

  ForgotPasswordDto({this.email});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ForgotPasswordDto && other.email == email;
  }

  @override
  int get hashCode => email.hashCode;
}
