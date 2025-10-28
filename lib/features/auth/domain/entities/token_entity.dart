class Token {
  final String? token;
  final String? refreshToken;
  final User? user;

  const Token({this.token, this.refreshToken, this.user});
}

class User {
  final String? id;
  final String? name;
  final String? email;
  final String? role;
  final bool? isDoctor;
  final String? hospitalOrClinic;

  const User({
    this.id,
    this.name,
    this.email,
    this.role,
    this.isDoctor,
    this.hospitalOrClinic,
  });
}
