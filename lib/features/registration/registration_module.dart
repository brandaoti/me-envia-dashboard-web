import 'package:flutter_modular/flutter_modular.dart';

import '../../core/types/types.dart';
import 'components/components.dart';
import 'registration_controller.dart';
import 'registration_screen.dart';

class RegistrationModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory<UserFormFieldsController>(
      (i) => UserFormFieldsControllerImpl(),
    ),
    Bind.factory<RegistrationController>(
      (i) => RegistrationControllerImpl(
        authRepository: i(),
      ),
    ),
  ];

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        RoutesName.login.name,
        child: (_, args) => const RegistrationScreen(),
      ),
    ];
  }
}
