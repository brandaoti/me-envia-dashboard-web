import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/core.dart';

import 'types/nav_bar_item_type.dart';

abstract class NavBarController {
  Stream<NavBarItemType> get navBarItemType;

  void onChangeNaveBarPage(NavBarItemType value);
  void naviteToWithNavBarItemType(NavBarItemType type);

  void logout();
  void dispose();
}

class NavBarControllerImpl implements NavBarController {
  final AuthProvider authProvider;
  final AuthController authController;

  NavBarControllerImpl({
    required this.authProvider,
    required this.authController,
  });

  final _navBarIndexSubject = BehaviorSubject<NavBarItemType>.seeded(
    NavBarItemType.home,
  );

  @override
  Stream<NavBarItemType> get navBarItemType => _navBarIndexSubject.stream;

  @override
  void onChangeNaveBarPage(NavBarItemType value) {
    if (!_navBarIndexSubject.isClosed) {
      _navBarIndexSubject.add(value);
    }
  }

  @override
  void naviteToWithNavBarItemType(NavBarItemType type) {
    onChangeNaveBarPage(type);
    switch (type) {
      case NavBarItemType.home:
        Modular.to.navigate(RoutesName.initial.name);
        break;
      case NavBarItemType.box:
        Modular.to.navigate(RoutesName.boxSections.name);
        break;
      case NavBarItemType.users:
        Modular.to.navigate(RoutesName.customers.name);
        break;
      case NavBarItemType.tips:
        Modular.to.navigate(RoutesName.mariaTips.name);
        break;
      case NavBarItemType.general:
        Modular.to.navigate(RoutesName.generalInformation.name);
        break;
    }
  }

  @override
  void dispose() {
    _navBarIndexSubject.close();
  }

  @override
  void logout() async {
    await authController.logout();
  }
}
