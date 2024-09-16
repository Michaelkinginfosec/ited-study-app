// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ited_study/core/providers/providers.dart';
import 'package:ited_study/feature/auth/domain/usecases/login_usecase.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState {
  final LoginStatus status;
  final String? error;
  final String? message;
  LoginState({this.status = LoginStatus.initial, this.error, this.message});

  LoginState copyWith({LoginStatus? status, String? error, String? message}) {
    return LoginState(
        status: status ?? this.status, error: error, message: message);
  }
}

class LoginNotifier extends StateNotifier<LoginState> {
  final LoginUsecase loginUsercase;

  LoginNotifier(this.loginUsercase) : super(LoginState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(status: LoginStatus.loading);
    try {
      final message = await loginUsercase(email, password);
      state = state.copyWith(status: LoginStatus.success, message: message);
    } catch (e) {
      state = state.copyWith(status: LoginStatus.failure, error: e.toString());
    }
  }
}

final loginNotifierProvider =
    StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier(ref.read(loginUsecaseProvider));
});
