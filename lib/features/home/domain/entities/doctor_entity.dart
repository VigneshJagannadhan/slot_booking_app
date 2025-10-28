class Doctor {
  final String id;
  final String name;
  final String hospitalOrClinic;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Doctor({
    required this.id,
    required this.name,
    required this.hospitalOrClinic,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Doctor &&
        other.id == id &&
        other.name == name &&
        other.hospitalOrClinic == hospitalOrClinic;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ hospitalOrClinic.hashCode;
  }
}
