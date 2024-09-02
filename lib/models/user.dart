class User {
  final String email;
  final String password;
  final String token; // For storing JWT token after login

  User({required this.email, required this.password, this.token = ''});

  // Convert User object to JSON
  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'token': token,
  };

  // Create User object from JSON
  factory User.fromJson(Map<String, dynamic> json) => User(
    email: json['email'],
    password: json['password'],
    token: json['token'] ?? '',
  );
}
