import 'package:flutter_modular/flutter_modular.dart';
import '../core.dart';

class AuthGuard implements RouteGuard {
  final authProvider = Modular.get<AuthProvider>();

  @override
  Future<bool> canActivate(String path, ModularRoute router) async {
    final authType = await authProvider.getAuthType();
    return authType == AuthType.authorized;
  }

  @override
  String? get guardedRoute => RoutesName.login.name;
}
