import 'package:flutter/material.dart';

import '../../../core/core.dart';

class Body extends StatelessWidget {
  final Widget child;
  final bool isScrollable;

  const Body({
    Key? key,
    required this.child,
    this.isScrollable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      height: context.screenHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _leftSide(context),
          ),
          Expanded(
            child: _rigthSide(context),
          ),
        ],
      ),
    );
  }

  Widget _leftSide(BuildContext context) {
    return Image.asset(
      Images.inventory,
      fit: BoxFit.fill,
      height: context.screenHeight,
    );
  }

  Widget _rigthSide(BuildContext context) {
    return Container(
      width: context.screenWidth,
      alignment: Alignment.center,
      height: context.screenHeight,
      child: Visibility(
        replacement: child,
        visible: isScrollable,
        child: SingleChildScrollView(child: child),
      ),
    );
  }
}
