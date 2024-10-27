import '../enums/user_role.dart';

class Profile {
  String? id;
  String? email;
  String? phone;
  UserRole? role;
  String? createdAt;
  String? externalId;

  Profile({
    this.id,
    this.email,
    this.phone,
    this.role,
    this.createdAt,
    this.externalId,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      role: json['role'] != null
          ? UserRoleExtension.fromString(json['role'] as String?)
          : null,
      createdAt: json['created_at'] as String?,
      externalId: json['external_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'role': role?.value,
      'created_at': createdAt,
      'external_id': externalId,
    };
  }
}
