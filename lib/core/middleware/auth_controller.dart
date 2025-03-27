import 'package:flutter_modular/flutter_modular.dart';

import '../core.dart';

abstract class AuthController {
  Future<void> init();
  Future<void> saveToken(String token);

  Future<void> logout();
}

class AuthControllerImpl implements AuthController {
  final AuthProvider authProvider;
  final AuthRepository repository;

  const AuthControllerImpl({
    required this.authProvider,
    required this.repository,
  });

  @override
  Future<void> init() async {
    final token = await authProvider.getToken();
    if (token != null) {
      addTokenToHeader(token);
    }
  }

  void addTokenToHeader(String token) {
    Modular.get<ApiClient>().addHeader('authorization', 'Bearer $token');
  }

  @override
  Future<void> saveToken(String token) async {
    await authProvider.saveToken(token);
    init();
  }

  @override
  Future<void> logout() async {
    await Future.wait([
      authProvider.deleteToken(),
      authProvider.deleteUser(),
    ]);
    Modular.to.navigate(RoutesName.login.name);
  }
}
