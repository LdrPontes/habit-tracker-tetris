class SignUpDto {
  String? fullName;
  String? email;
  String? password;

  SignUpDto({this.fullName, this.email, this.password});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SignUpDto &&
        other.fullName == fullName &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => fullName.hashCode ^ email.hashCode ^ password.hashCode;
}
