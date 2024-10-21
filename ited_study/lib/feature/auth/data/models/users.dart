import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/user_entity.dart';

part 'users.g.dart';

@HiveType(typeId: 0)
class Users extends Equatable {
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

  const Users({
    required this.fullName,
    required this.email,
    required this.department,
    required this.level,
    required this.password,
    this.verified = false,
    required this.schoolId,
  });

  Users copyWith({
    String? fullName,
    String? email,
    String? department,
    String? level,
    String? password,
    bool? verified,
    String? schoolId,
  }) {
    return Users(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      department: department ?? this.department,
      level: level ?? this.level,
      password: password ?? this.password,
      verified: verified ?? this.verified,
      schoolId: schoolId ?? this.schoolId,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      fullName: fullName,
      email: email,
      department: department,
      level: level,
      password: password,
      verified: verified,
      schoolId: schoolId,
    );
  }

  static Users fromEntity(UserEntity entity) {
    return Users(
      fullName: entity.fullName,
      email: entity.email,
      department: entity.department,
      level: entity.level,
      password: entity.password,
      verified: entity.verified,
      schoolId: entity.schoolId,
    );
  }

  @override
  List<Object?> get props {
    return [
      fullName,
      email,
      department,
      level,
      password,
      verified,
    ];
  }
}
