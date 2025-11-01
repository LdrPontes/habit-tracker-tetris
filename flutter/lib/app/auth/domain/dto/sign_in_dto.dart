class SignInDto {
  String? email;
  String? password;

  SignInDto({this.email, this.password});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SignInDto &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
