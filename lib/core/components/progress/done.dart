import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../../values/values.dart';

class Done extends StatelessWidget {
  final String src;
  final String title;
  final double heigth;
  final String subtitle;
  final Color textColor;

  const Done({
    Key? key,
    this.heigth = 280,
    this.title = '',
    this.subtitle = '',
    this.src = Svgs.forgotPassword02,
    this.textColor = AppColors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _illustration(),
        const VerticalSpacing(height: 64),
        _title(),
        const VerticalSpacing(height: 16),
        _subtitle()
      ],
    );
  }

  Widget _illustration() {
    return Center(
      child: SvgPicture.asset(
        src,
        width: heigth,
        height: heigth,
      ),
    );
  }

  Widget _title() {
    return AutoSizeText(
      title,
      minFontSize: 24,
      textAlign: TextAlign.center,
      style: TextStyles.resgitrationHeaderTitle.copyWith(
        fontSize: 28,
        color: textColor,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget _subtitle() {
    return AutoSizeText(
      subtitle,
      minFontSize: 18,
      textAlign: TextAlign.center,
      style: TextStyles.resgitrationHeaderTitle.copyWith(
        fontSize: 21,
        color: textColor,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
