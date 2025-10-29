class UserEntity {
  final String? id;
  final String? name;
  final String? email;
  final String? role;
  final bool? isDoctor;
  final String? hospitalOrClinic;

  UserEntity({
    this.id,
    this.name,
    this.email,
    this.role,
    this.isDoctor,
    this.hospitalOrClinic,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      isDoctor: json['isDoctor'],
      hospitalOrClinic: json['hospitalOrClinic'],
    );
  }
}
