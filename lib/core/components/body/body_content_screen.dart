import 'package:flutter/material.dart';

import '../../../features/features.dart';
import '../../core.dart';

class BodyContentScreen extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const BodyContentScreen({
    Key? key,
    required this.child,
    this.padding = Paddings.contentBody,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _leftSide(),
        Expanded(
          child: _rightSide(context),
        ),
      ],
    );
  }

  Widget _leftSide() {
    return const NavBarWidget();
  }

  Widget _rightSide(BuildContext context) {
    return Container(
      child: child,
      padding: padding,
      width: double.infinity,
      height: context.screenHeight,
    );
  }
}
