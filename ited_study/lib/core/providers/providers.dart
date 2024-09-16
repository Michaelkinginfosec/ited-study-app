import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ited_study/feature/auth/data/repositories/user_repository_impl.dart';
import 'package:ited_study/feature/auth/domain/usecases/login_usecase.dart';
import 'package:ited_study/feature/auth/domain/usecases/resend_otp_usecase.dart';
import 'package:ited_study/feature/auth/domain/usecases/verify_otp_usecase.dart';
import '../../feature/auth/data/datasources/remoteDataSource/user_remote_datasource.dart';
import '../../feature/auth/domain/repositories/user_repository.dart';
import '../../feature/auth/domain/usecases/sign_up_usecase.dart';

//Navigation provider
final navigationIndexProvider = StateProvider<int>((ref) => 0);

//user repository provider
final usersRepositoryProvider = Provider<UsersRepository>((ref) {
  return UserRepositoryImpl(ref.read(usersRemoteDataSourceProvider));
});

// Dio Provider
final dioProvider = Provider<Dio>(
  (ref) {
    return Dio(BaseOptions(
      baseUrl: dotenv.env['API_BASE_URL'] ?? '',
    ));
  },
);

// Users Remote Data Source Provider
final usersRemoteDataSourceProvider = Provider<UsersRemoteDataSource>(
  (ref) {
    return UserRemoteDatasourceImp(ref.read(dioProvider));
  },
);

// Sign Up Use Case Provider
final signUpUseCaseProvider = Provider<SignUpUseCase>(
  (ref) {
    return SignUpUseCase(ref.read(usersRepositoryProvider));
  },
);

//verify otp provider
final verifyOTPUsecaseProvider = Provider<VerifyOTPUsecase>(
  (ref) {
    return VerifyOTPUsecase(ref.read(usersRepositoryProvider));
  },
);

//login usecase provider
final loginUsecaseProvider = Provider<LoginUsecase>(
  (ref) {
    return LoginUsecase(ref.read(usersRepositoryProvider));
  },
);
final resendOTPUsecaseProvider = Provider<ResendOTPUsecase>((ref) {
  return ResendOTPUsecase(ref.read(usersRepositoryProvider));
});
