import 'package:rxdart/rxdart.dart';

import '../../core/core.dart';

import 'states/change_password_state.dart';
import 'states/forgot_password_states.dart';

abstract class ForgotPasswordController {
  Stream<bool> get isPasswordVisibleStream;
  Stream<ForgotPasswordState> get forgotPasswordStateStream;
  Stream<ChangePasswordState> get changePasswordStateStream;

  void togglePasswordVisible(bool value);

  void dispose();

  Future<void> handleSendEmail(String email);
  Future<void> handleChangePassword(String? token, String password);
}

class ForgotPasswordControllerImpl implements ForgotPasswordController {
  final AuthRepository authRepository;

  ForgotPasswordControllerImpl({
    required this.authRepository,
  });

  final _forgotPasswordStateSubject =
      BehaviorSubject<ForgotPasswordState>.seeded(
    const ForgotPasswordInitialState(),
  );

  final _changePasswordStateSubject =
      BehaviorSubject<ChangePasswordState>.seeded(
    const ChangePasswordInitialState(),
  );

  final _isPasswordStreamSubject = BehaviorSubject<bool>.seeded(true);

  @override
  Stream<ForgotPasswordState> get forgotPasswordStateStream =>
      _forgotPasswordStateSubject.stream.distinct();

  @override
  Stream<ChangePasswordState> get changePasswordStateStream =>
      _changePasswordStateSubject.stream.distinct();

  @override
  Stream<bool> get isPasswordVisibleStream =>
      _isPasswordStreamSubject.stream.distinct();

  void onChangeChangePasswordState(ChangePasswordState newState) {
    if (!_changePasswordStateSubject.isClosed) {
      _changePasswordStateSubject.add(newState);
    }
  }

  void onChangeForgotPasswordState(ForgotPasswordState newState) {
    if (!_forgotPasswordStateSubject.isClosed) {
      _forgotPasswordStateSubject.add(newState);
    }
  }

  @override
  void togglePasswordVisible(bool value) {
    if (!_isPasswordStreamSubject.isClosed) {
      _isPasswordStreamSubject.add(value);
    }
  }

  @override
  Future<void> handleSendEmail(String email) async {
    onChangeForgotPasswordState(const ForgotPasswordLoadingState());

    try {
      await authRepository.forgotPassword(email.trim());
      onChangeForgotPasswordState(const ForgotPasswordSucessState());
    } on ApiClientError catch (e) {
      onChangeForgotPasswordState(ForgotPasswordErrorState(
        message: e.message ?? '',
      ));
    }
  }

  @override
  Future<void> handleChangePassword(String? token, String password) async {
    onChangeChangePasswordState(const ChangePasswordLoadingState());

    try {
      await authRepository.changedPassword(
        token: token ?? '',
        newPassword: password,
      );
      onChangeChangePasswordState(const ChangePasswordSucessState());
    } on ApiClientError catch (e) {
      onChangeChangePasswordState(ChangePasswordErrorState(
        message: e.message ?? '',
      ));
    }
  }

  @override
  void dispose() {
    _isPasswordStreamSubject.close();
    _forgotPasswordStateSubject.close();
    _changePasswordStateSubject.close();
  }
}
