import 'dart:convert';

import 'package:hive/hive.dart';

part 'user_entity.g.dart';

@HiveType(typeId: 0)
class UserEntity extends HiveObject {
  @HiveField(0)
  final String fullName;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String department;
  @HiveField(3)
  final String level;
  @HiveField(4)
  final String password;
  @HiveField(5)
  final bool verified;
  @HiveField(6)
  final String schoolId;

  UserEntity({
    required this.fullName,
    required this.email,
    required this.department,
    required this.level,
    required this.password,
    this.verified = false,
    required this.schoolId,
  });

  // Map<String, dynamic> toJson() {
  //   final data = {
  //     'fullName': fullName,
  //     'email': email,
  //     'department': department,
  //     'level': level,
  //     'password': password,
  //     'verified': verified,
  //   };
  //   return data;
  // }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'email': email,
      'department': department,
      'level': level,
      'password': password,
      'verified': verified,
      'schoolId': schoolId,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      department: map['department'] as String,
      level: map['level'] as String,
      password: map['password'] as String,
      verified: map['verified'] as bool? ?? false,
      schoolId: map['schoolId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
