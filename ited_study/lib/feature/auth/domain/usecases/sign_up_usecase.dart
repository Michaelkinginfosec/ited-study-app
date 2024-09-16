// lib/feature/auth/domain/usecases/sign_up_usecase.dart

import 'package:ited_study/feature/auth/data/models/users.dart';

import '../repositories/user_repository.dart';

class SignUpUseCase {
  final UsersRepository repository;

  SignUpUseCase(this.repository);

  Future<String> call(Users user) async {
    return await repository.signUp(user);
  }
}
