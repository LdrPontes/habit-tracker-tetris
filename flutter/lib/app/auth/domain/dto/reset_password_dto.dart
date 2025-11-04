class ResetPasswordDto {
  String? newPassword;
  String? confirmPassword;

  ResetPasswordDto({this.newPassword, this.confirmPassword});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ResetPasswordDto &&
        other.newPassword == newPassword &&
        other.confirmPassword == confirmPassword;
  }

  @override
  int get hashCode => newPassword.hashCode ^ confirmPassword.hashCode;
}
