class User {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
  });

  User copyWith({String? id, String? name, String? email, String? avatarUrl}) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatarUrl: json['avatar_url'],
    );
  }

  factory User.fromSupabaseUser(Map<String, dynamic> user) {
    return User(
      id: user['id'],
      name: user['user_metadata']['full_name'],
      email: user['email'],
      avatarUrl: user['user_metadata']['avatar_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'avatar_url': avatarUrl};
  }

  @override
  String toString() {
    return '''User(id: $id, name: $name, email: $email, avatarUrl: $avatarUrl)''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.avatarUrl == avatarUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ email.hashCode ^ avatarUrl.hashCode;
  }
}
