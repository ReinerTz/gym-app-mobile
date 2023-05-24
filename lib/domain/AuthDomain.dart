class AuthDomain {
  final String email;
  final String password;

  AuthDomain({required this.email, required this.password});

  factory AuthDomain.fromJson(Map<String, dynamic> json) {
    return AuthDomain(
      email: json['email'],
      password: json['password']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password
    };
  }
}

class AuthResponse {
  String token;

  AuthResponse({required this.token});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(token: json['token']);
  }
}
