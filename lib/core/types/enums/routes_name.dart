import 'package:flutter_modular/flutter_modular.dart';

enum RoutesName {
  initial,
  login,
  home,
  forgotPassword,
  registration,
  boxSections,
  packageDetail,
  customers,
  listCustomesItems,
  mariaTips,
  generalInformation,
  contact,
}

const Map<RoutesName, String> _mapToRouters = {
  RoutesName.initial: '/',
  RoutesName.home: '/home',
  RoutesName.login: '/login',
  RoutesName.contact: '/contato',
  RoutesName.mariaTips: '/dicas',
  RoutesName.customers: '/clientes',
  RoutesName.boxSections: '/caixas',
  RoutesName.generalInformation: '/geral',
  RoutesName.registration: '/registration',
  RoutesName.forgotPassword: '/forgot_password',
  RoutesName.listCustomesItems: '/clientes/itens',
  RoutesName.packageDetail: '/caixas/detalhes/:id',
};

extension RoutesNameExtension on RoutesName {
  String get name {
    return _mapToRouters[this] ?? '/';
  }

  String get linkNavigate {
    final router = _mapToRouters[this];
    final module = Modular.to.modulePath;

    return '$module$router';
  }

  String packageDetailsById(String id) {
    return name.replaceAll(':id', id);
  }
}

extension FromRoutesNameExtension on String {
  RoutesName get fromRouter {
    return _mapToRouters.keys.firstWhere((it) => this == it.name);
  }
}
