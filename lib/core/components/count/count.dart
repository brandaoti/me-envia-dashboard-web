import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../helpers/extensions.dart';
import '../../values/values.dart';

class Count extends StatelessWidget {
  final int totalValue;
  final Color? textColor;
  final Color? backgroundColor;
  final EdgeInsets contentPadding;
  final bool isMoney;
  final BoxConstraints constraints;
  final Size? size;

  const Count({
    Key? key,
    required this.totalValue,
    this.textColor,
    this.backgroundColor,
    this.contentPadding = Paddings.horizontalSmall,
    this.isMoney = false,
    this.constraints = Sizes.countItems,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (size != null) {
      return Container(
        padding: contentPadding,
        alignment: Alignment.center,
        child: _totalClientItemText(),
        height: size!.height,
        width: size!.width,
        decoration: Decorations.stepsDecoration(true).copyWith(
          color: backgroundColor,
        ),
      );
    }

    return Container(
      padding: contentPadding,
      alignment: Alignment.center,
      child: _totalClientItemText(),
      constraints: constraints,
      decoration: Decorations.stepsDecoration(true).copyWith(
        color: backgroundColor,
      ),
    );
  }

  Widget _totalClientItemText() {
    return AutoSizeText(
      isMoney ? totalValue.formatterMoneyToBrasilian : totalValue.toString(),
      style: TextStyles.homeHeaderSubtitle.copyWith(
        fontWeight: FontWeight.w400,
        color: textColor ?? AppColors.whiteDefault,
      ),
    );
  }
}
