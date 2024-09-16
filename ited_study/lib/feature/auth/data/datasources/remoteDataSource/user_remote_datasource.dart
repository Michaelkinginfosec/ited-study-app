import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ited_study/feature/auth/data/models/users.dart';
import 'package:ited_study/feature/auth/domain/entities/user_entity.dart';

import '../../../../../core/errors/errors.dart';

abstract class UsersRemoteDataSource {
  Future<String> signUp(Users user);
  Future<String> verifyOTP(String otp);
  Future<String> login(String email, String password);
  Future<void> storeToken(String token);
  Future<void> logout();
  Future<Users> getUser(String userId);
  Future<void> storeUser(Users user);
  Future<String> resendVerificationCode(String email);
}

class UserRemoteDatasourceImp implements UsersRemoteDataSource {
  final Dio dio;

  UserRemoteDatasourceImp(this.dio);

  @override
  Future<String> signUp(Users user) async {
    try {
      final response = await dio.post(
        '/users/create-account',
        data: user.toEntity().toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null && response.data is Map<String, dynamic>) {
          final responseData = response.data as Map<String, dynamic>;
          final message =
              responseData['message'] as String? ?? 'No message available';
          return message;
        } else {
          throw SignUpException('Unexpected response format');
        }
      } else {
        throw SignUpException(
            'Sign up failed with status code: ${response.statusCode}');
      }
    } on DioException catch (dioError) {
      if (dioError.response != null) {
        if (dioError.response!.statusCode == 409) {
          throw SignUpException('Email already exists');
        } else {
          throw SignUpException(
            dioError.response!.data['message'] as String? ?? 'Sign up failed',
          );
        }
      } else {
        throw SignUpException('Network or server error');
      }
    } catch (e) {
      throw SignUpException('Unexpected error occurred: $e');
    }
  }

  @override
  Future<String> verifyOTP(String otp) async {
    try {
      final response = await dio.post(
        '/users/verify-otp',
        data: {'otp': otp},
      );

      // Check if the status code is 200 or 201
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null && response.data is Map<String, dynamic>) {
          final responseData = response.data as Map<String, dynamic>;
          final message =
              responseData['message'] as String? ?? 'No message available';
          return message;
        } else {
          throw VerifyOTPException('Unexpected response format');
        }
      } else {
        throw VerifyOTPException(
            'Failed with status code: ${response.statusCode}');
      }
    } on DioException catch (dioError) {
      // Handle specific Dio errors
      if (dioError.response != null) {
        if (dioError.response!.statusCode == 401) {
          throw VerifyOTPException('Invalid or expired OTP');
        } else {
          final errorMessage = dioError.response!.data['message'] as String? ??
              'Failed to verify OTP';
          throw VerifyOTPException(errorMessage);
        }
      } else {
        throw VerifyOTPException('Network or server error');
      }
    } catch (e) {
      // Handle any other errors
      throw VerifyOTPException('Unexpected error occurred: ${e.toString()}');
    }
  }

  @override
  Future<String> login(String email, String password) async {
    try {
      final response = await dio
          .post('/users/login', data: {'email': email, 'password': password});
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null && response.data is Map<String, dynamic>) {
          final responseData = response.data as Map<String, dynamic>;
          final message =
              responseData['message'] as String? ?? 'No message available';
          final token = responseData['accessToken'] as String?;
          if (token != null) {
            await storeToken(token);
          }
          return message;
        } else {
          throw LoginException('Unexpected response format');
        }
      } else {
        throw LoginException('Failed with status code: ${response.statusCode}');
      }
    } on DioException catch (dioError) {
      if (dioError.response != null) {
        if (dioError.response!.statusCode == 401 &&
            dioError.response!.statusMessage ==
                "User is not verified, verify your account to login") {
          throw LoginException('verify your email to continue');
        } else if (dioError.response!.statusCode == 401 &&
            dioError.response!.statusMessage == "Invalid Credentials") {
          throw LoginException("Invalid Credentials");
        } else {
          throw LoginException(
            dioError.response!.data['message'] as String? ?? 'Login failed',
          );
        }
      } else {
        throw LoginException('Network or server error');
      }
    } catch (e) {
      throw LoginException('Unexpected error occurred: $e');
    }
  }

  @override
  Future<Users> getUser(String userId) async {
    try {
      final response = await dio.get('/users/$userId');
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null && response.data is Map<String, dynamic>) {
          final userEntity =
              UserEntity.fromMap(response.data as Map<String, dynamic>);
          return Users.fromEntity(userEntity);
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception('Failed with status code: ${response.statusCode}');
      }
    } on DioException catch (dioError) {
      if (dioError.response != null) {
        // Handle specific error scenarios based on status codes
        if (dioError.response!.statusCode == 404 ||
            dioError.response!.statusCode == 400) {
          throw Exception('User not found');
        } else {
          throw Exception(dioError.response!.data['message'] as String? ??
              'Failed to fetch user');
        }
      } else {
        throw Exception('Network or server error');
      }
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }

  @override
  Future<String> resendVerificationCode(String email) async {
    try {
      final response =
          await dio.post("/users/resend-verification", data: {"email": email});
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null && response.data is Map<String, dynamic>) {
          final responseData = response.data as Map<String, dynamic>;
          final message = responseData['message'] as String? ?? 'otp sent';
          return message;
        } else {
          throw ResendCodeException("Unexpected response format!");
        }
      } else {
        throw ResendCodeException("Resend OTP failed:  ${response.statusCode}");
      }
    } on DioException catch (dioError) {
      if (dioError.response != null) {
        if (dioError.response!.statusCode == 404) {
          throw ResendCodeException("User not found!");
        } else if (dioError.response!.statusCode == 400) {
          throw ResendCodeException("User verified");
        } else {
          throw Exception(dioError.response!.data['message'] as String? ??
              "can't send OTP code");
        }
      } else {
        throw ResendCodeException("Network or server error");
      }
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }

  @override
  Future<void> storeUser(Users user) async {
    var box = Hive.box("usersBox");
    await box.put("users", user);
  }

  @override
  Future<void> storeToken(String token) async {
    var box = Hive.box("sessionBox");
    await box.put("accessToken", token);
  }

  @override
  Future<void> logout() async {
    var box = Hive.box("sessionBox");
    await box.delete("accessToken");
  }
}