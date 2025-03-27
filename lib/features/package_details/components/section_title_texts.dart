import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/values/values.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final Color? color;
  final double? fontSize;
  final bool isSmallStyle;
  final TextAlign textAlign;

  const SectionTitle({
    Key? key,
    this.color,
    this.fontSize,
    this.isSmallStyle = false,
    this.textAlign = TextAlign.left,
    this.title = Strings.sectionTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = TextStyles.sectionTitleStyle.copyWith(
      fontSize: fontSize ?? 18,
      fontWeight: FontWeight.w600,
      color: color ?? AppColors.secondary,
    );

    return AutoSizeText(
      title,
      textAlign: textAlign,
      style: isSmallStyle
          ? style
          : TextStyles.sectionTitleStyle.copyWith(
              fontSize: fontSize,
              color: color ?? AppColors.secondary,
            ),
    );
  }
}
