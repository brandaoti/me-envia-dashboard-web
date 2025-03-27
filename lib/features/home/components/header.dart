import 'package:flutter/material.dart';

import '../../../core/values/values.dart';
import 'header_title.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final Widget? child;
  final EdgeInsets padding;
  final EdgeInsets titlePadding;
  final VoidCallback? openNavBar;
  final bool useAddicionalInformation;

  const Header({
    Key? key,
    this.child,
    required this.openNavBar,
    this.padding = Paddings.allDefault,
    this.titlePadding = Paddings.vertical,
    this.height = Dimens.homeHeaderHeight,
    this.useAddicionalInformation = false,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: padding,
        width: double.infinity,
        height: preferredSize.height,
        color: AppColors.whiteDefault,
        alignment: Alignment.centerLeft,
        child: Visibility(
          child: _headerBody(),
          visible: useAddicionalInformation,
        ),
      ),
    );
  }

  Widget _headerBody() {
    return AnimatedSwitcher(
      duration: Durations.transition,
      child: child ?? _defaultAdditianalInformation(),
    );
  }

  Widget _defaultAdditianalInformation() {
    return Padding(
      padding: titlePadding,
      child: const HeaderTitle(),
    );
  }
}
