import 'package:rxdart/rxdart.dart';

import '../models/user_information.dart';
import '../types/types.dart';

abstract class UserFormFieldsController {
  Stream<bool> get isPasswordVisibleStream;

  void togglePasswordVisible(bool value);
  UserInformation getUserInformation();

  void onFormChanged(UserFormType form, String value);

  void dispose();
}

class UserFormFieldsControllerImpl implements UserFormFieldsController {
  final _userInformation = UserInformation();

  final _isPasswordVisibleSubject = BehaviorSubject<bool>.seeded(true);

  @override
  Stream<bool> get isPasswordVisibleStream =>
      _isPasswordVisibleSubject.stream.distinct();

  final _isPasswordStream = BehaviorSubject.seeded(true);

  void togglePasswordVisiblity() {
    if (!_isPasswordStream.isClosed) {
      final newValue = !_isPasswordStream.value;
      _isPasswordStream.add(newValue);
    }
  }

  @override
  void onFormChanged(UserFormType form, String value) {
    switch (form) {
      case UserFormType.name:
        _userInformation.name = value;
        break;
      case UserFormType.email:
        _userInformation.email = value;
        break;
      case UserFormType.securityCode:
        _userInformation.securityCode = value;
        break;
      case UserFormType.password:
        _userInformation.password = value;
        break;
      case UserFormType.confirmPassword:
        break;
    }
  }

  @override
  void togglePasswordVisible(bool value) {
    if (!_isPasswordVisibleSubject.isClosed) {
      _isPasswordVisibleSubject.add(value);
    }
  }

  @override
  UserInformation getUserInformation() {
    return _userInformation;
  }

  @override
  void dispose() {
    _isPasswordVisibleSubject.close();
  }
}
