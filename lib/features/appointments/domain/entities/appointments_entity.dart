class AppointmentEntity {
  final String? id;
  final String? name;
  final String? phone;
  final DateTime? startAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AppointmentEntity({
    this.id,
    this.name,
    this.phone,
    this.startAt,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'startAt': startAt?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppointmentEntity &&
        other.id == id &&
        other.name == name &&
        other.phone == phone &&
        other.startAt == startAt &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        startAt.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
