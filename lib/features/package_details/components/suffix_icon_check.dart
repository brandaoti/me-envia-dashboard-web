import 'package:flutter/material.dart';

import '../../../core/values/values.dart';

class SuffixIconCheck extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final Color? decorationColor;
  final EdgeInsetsGeometry padding;
  final double width;
  final double height;

  const SuffixIconCheck({
    Key? key,
    this.icon = Icons.check,
    this.iconColor = AppColors.whiteDefault,
    this.decorationColor = AppColors.alertGreenColor,
    this.padding = const EdgeInsets.all(10.0),
    this.width = 20,
    this.height = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: decorationColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 12,
          color: iconColor,
        ),
      ),
    );
  }
}
