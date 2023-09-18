class UserDomain {
  final String id;
  final String name;
  final String email;
  final String? avatar;

  UserDomain({required this.id, required this.name, required this.email, this.avatar});

  factory UserDomain.fromJson(Map<String, dynamic> json) {
    return UserDomain(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
