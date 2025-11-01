class DoctorEntity {
  final String? id;
  final String? name;
  final String? hospitalOrClinic;
  final num? rating;
  final String? designation;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const DoctorEntity({
    this.id,
    this.name,
    this.hospitalOrClinic,
    this.rating,
    this.designation,
    this.createdAt,
    this.updatedAt,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DoctorEntity &&
        other.id == id &&
        other.name == name &&
        other.hospitalOrClinic == hospitalOrClinic;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ hospitalOrClinic.hashCode;
  }
}
