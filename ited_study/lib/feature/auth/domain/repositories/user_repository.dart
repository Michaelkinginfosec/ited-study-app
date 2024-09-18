import 'package:ited_study/feature/auth/data/models/users.dart';

abstract class UsersRepository {
  Future<String> signUp(Users user);
  Future<String> verifyOTP(String otp);
  Future<String> login(String email, String password);
  Future<void> storeToken(String token);
  Future<String> logout();
  Future<Users> getUser(String userId);
  Future<void> storeUser(Users user);
  Future<String> resendVerificationCode(String email);
  // Future<bool> isLoggedIn();
}
