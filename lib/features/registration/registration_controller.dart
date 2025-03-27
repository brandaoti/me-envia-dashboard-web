import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/core.dart';

import 'states/registration_state.dart';
import 'models/models.dart';

abstract class RegistrationController {
  Stream<RegistrationState> get registrationStateStream;

  Future<void> handleRegistrationNewUser({
    required UserInformation userInformation,
  });

  void dispose();
}

class RegistrationControllerImpl implements RegistrationController {
  final AuthRepository authRepository;

  RegistrationControllerImpl({
    required this.authRepository,
  });

  final _registrationStateSubject = BehaviorSubject<RegistrationState>();

  @override
  Stream<RegistrationState> get registrationStateStream =>
      _registrationStateSubject.stream.distinct();

  void onChangeRegistrationState(RegistrationState newState) {
    if (!_registrationStateSubject.isClosed) {
      _registrationStateSubject.add(newState);
    }
  }

  void _handleSaveToken() async {
    await Future.delayed(Durations.transitionToNavigate);
    Modular.to.navigate(RoutesName.login.name);
  }

  @override
  Future<void> handleRegistrationNewUser({
    required UserInformation userInformation,
  }) async {
    onChangeRegistrationState(const RegistrationLoadingState());

    try {
      final newUser = CreateNewUser.fromApi(userInformation);
      await authRepository.createUser(newUser);

      _handleSaveToken();
      onChangeRegistrationState(const RegistrationSuccessState());
    } on ApiClientError catch (e) {
      onChangeRegistrationState(RegistrationErrorState(
        message: e.message,
      ));
    }
  }

  @override
  void dispose() {
    _registrationStateSubject.close();
  }
}
