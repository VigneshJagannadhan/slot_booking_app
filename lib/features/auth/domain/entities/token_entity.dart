class Token {
  final String token;
  final String refreshToken;
  final User user;

  const Token({
    required this.token,
    required this.refreshToken,
    required this.user,
  });
}

class User {
  final String id;
  final String name;
  final String email;
  final String role;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });
}
