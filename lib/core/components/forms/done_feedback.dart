import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../core.dart';

class DoneFeedback extends StatelessWidget {
  final String title;
  final String subtitle;

  const DoneFeedback({
    Key? key,
    this.subtitle = Strings.timeToBoxOrders,
    this.title = Strings.registrationCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _checkSucess(),
        const VerticalSpacing(height: 26),
        _title(),
        const VerticalSpacing(height: 28),
        _subtitle()
      ],
    );
  }

  Widget _checkSucess() {
    const color = AppColors.alertGreenColor;

    return Container(
      width: 144,
      height: 144,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.1),
      ),
      child: const Icon(Icons.check, size: 80, color: color),
    );
  }

  Widget _title() {
    return AutoSizeText(
      title,
      minFontSize: 24,
      textAlign: TextAlign.center,
      style: TextStyles.resgitrationHeaderTitle,
    );
  }

  Widget _subtitle() {
    return AutoSizeText(
      subtitle,
      minFontSize: 24,
      textAlign: TextAlign.center,
      style: TextStyles.resgitrationHeaderTitle.copyWith(
        fontSize: 18,
        height: 1.2,
        color: AppColors.black,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
