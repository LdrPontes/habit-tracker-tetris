class SignInDto {
  final String email;
  final String password;

  const SignInDto({required this.email, required this.password});

  SignInDto copyWith({String? email, String? password}) {
    return SignInDto(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  factory SignInDto.fromJson(Map<String, dynamic> json) {
    return SignInDto(email: json['email'], password: json['password']);
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }

  @override
  String toString() => '''SignInDto(email: $email, password: $password)''';

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
