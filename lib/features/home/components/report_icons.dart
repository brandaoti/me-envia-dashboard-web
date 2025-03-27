import 'package:flutter/material.dart';

import '../../../core/values/values.dart';

class ReportIcons extends StatelessWidget {
  final double size;
  final Color color;
  final IconData? icon;

  const ReportIcons({
    Key? key,
    this.icon,
    this.size = Dimens.buttonHeight,
    this.color = AppColors.alertGreenColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: Icon(icon ?? Icons.arrow_upward_rounded, color: color),
      decoration: Decorations.paginateItems(true, color.withOpacity(0.2)),
    );
  }
}
