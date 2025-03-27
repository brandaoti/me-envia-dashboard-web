import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/core.dart';
import 'states/login_state.dart';

abstract class LoginController {
  Stream<LoginState> get loginStateStream;
  Stream<bool> get isPasswordVisibleStream;

  void togglePasswordVisible(bool value);

  void navigateToResgisterScreen();
  void navigateToForgotPasswordScreen();

  void dispose();
  Future<void> handleSubmit(String email, String password);
}

class LoginControllerImpl implements LoginController {
  final AuthRepository authRepository;
  final AuthController authController;

  LoginControllerImpl({
    required this.authRepository,
    required this.authController,
  });

  final _loginStateStream = BehaviorSubject<LoginState>.seeded(
    const LoginInitialState(),
  );

  final _isPasswordVisibleSubject = BehaviorSubject<bool>.seeded(true);

  @override
  Stream<LoginState> get loginStateStream =>
      _loginStateStream.stream.distinct();

  @override
  Stream<bool> get isPasswordVisibleStream =>
      _isPasswordVisibleSubject.stream.distinct();

  @override
  void togglePasswordVisible(bool value) {
    if (!_isPasswordVisibleSubject.isClosed) {
      _isPasswordVisibleSubject.add(value);
    }
  }

  void onChangeLoginState(LoginState newState) {
    if (!_loginStateStream.isClosed) {
      _loginStateStream.add(newState);
    }
  }

  void navigateTo(String token) async {
    await authController.saveToken(token);
    Modular.to.navigate(RoutesName.initial.name, replaceAll: true);
  }

  @override
  Future<void> handleSubmit(String email, String password) async {
    onChangeLoginState(const LoginLoadingState());

    try {
      final loginResquest = LoginRequest(
        email: email.trim(),
        password: password.trim(),
      );

      final token = await authRepository.login(loginResquest);
      onChangeLoginState(const LoginSucessState());

      navigateTo(token);
    } on ApiClientError catch (e) {
      onChangeLoginState(LoginErrorState(message: e.message ?? ''));
    }
  }

  @override
  void dispose() {
    _loginStateStream.close();
    _isPasswordVisibleSubject.close();
  }

  @override
  void navigateToForgotPasswordScreen() {
    Modular.to.navigate(RoutesName.forgotPassword.name);
  }

  @override
  void navigateToResgisterScreen() {
    Modular.to.navigate(RoutesName.registration.name);
  }
}
