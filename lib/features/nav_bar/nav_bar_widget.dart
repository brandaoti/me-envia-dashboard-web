import 'package:flutter_modular/flutter_modular.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';

import 'components/nav_bar_item.dart';
import 'types/nav_bar_item_type.dart';
import 'nav_bar_controller.dart';

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({Key? key}) : super(key: key);
  @override
  _NavBarWidgetState createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  final _controller = Modular.get<NavBarController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: Dimens.navBarMaxWith,
        height: context.screenHeight,
        decoration: Decorations.navBar,
        child: Center(
          child: ConstrainedBox(
            child: _headerMenuItems(),
            constraints: const BoxConstraints(maxHeight: 530),
          ),
        ),
      ),
    );
  }

  Widget _headerMenuItems() {
    return Column(
      children: [
        _logo(),
        const VerticalSpacing(
          height: 32,
        ),
        Expanded(child: _listOfHeaderMenu()),
      ],
    );
  }

  Widget _logo() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: SvgPicture.asset(
          Svgs.logoWhite,
        ),
      ),
    );
  }

  Widget _listOfHeaderMenu() {
    return StreamBuilder<NavBarItemType>(
      stream: _controller.navBarItemType,
      builder: (context, snapshot) {
        final currentType = snapshot.data ?? NavBarItemType.home;
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _listOfGeneralItems(currentType),
            _logout(),
          ],
        );
      },
    );
  }

  Widget _listOfGeneralItems(
    NavBarItemType currentType,
  ) {
    return Column(
      children: [
        NaveBarItem(
          iconPath: Svgs.iconHome,
          title: Strings.navBarScreenNames[0],
          isActive: currentType == NavBarItemType.home,
          onPressed: () => _controller.naviteToWithNavBarItemType(
            NavBarItemType.home,
          ),
        ),
        NaveBarItem(
          iconPath: Svgs.iconBox,
          title: Strings.navBarScreenNames[1],
          isActive: currentType == NavBarItemType.box,
          onPressed: () => _controller.naviteToWithNavBarItemType(
            NavBarItemType.box,
          ),
        ),
        NaveBarItem(
          iconPath: Svgs.iconUser,
          title: Strings.navBarScreenNames[2],
          isActive: currentType == NavBarItemType.users,
          onPressed: () => _controller.naviteToWithNavBarItemType(
            NavBarItemType.users,
          ),
        ),
        NaveBarItem(
          iconPath: Svgs.iconTips,
          title: Strings.navBarScreenNames[3],
          isActive: currentType == NavBarItemType.tips,
          onPressed: () => _controller.naviteToWithNavBarItemType(
            NavBarItemType.tips,
          ),
        ),
        NaveBarItem(
          iconPath: Svgs.iconInfo,
          title: Strings.navBarScreenNames[4],
          isActive: currentType == NavBarItemType.general,
          onPressed: () => _controller.naviteToWithNavBarItemType(
            NavBarItemType.general,
          ),
        ),
      ],
    );
  }

  Widget _logout() {
    return NaveBarItem(
      iconPath: Svgs.iconLogout,
      onPressed: _controller.logout,
      title: Strings.navBarScreenNames[5],
    );
  }
}
