import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/helpers/extensions.dart';
import '../../../core/values/values.dart';
import 'report_icons.dart';

class PaymentReport extends StatelessWidget {
  final double paymentReceived;
  final double paymentToReceive;

  const PaymentReport({
    Key? key,
    required this.paymentReceived,
    required this.paymentToReceive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _body(),
      padding: Paddings.allDefaultSmall,
      constraints: Sizes.homeReportPayments,
      decoration: Decorations.cardOrderItem(false),
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _contenTitle(),
        const VerticalSpacing(
          height: 24,
        ),
        _content(),
      ],
    );
  }

  Widget _contenTitle() {
    return AutoSizeText(
      Strings.payments,
      style: TextStyles.homeHeaderTitle.copyWith(
        fontSize: 24,
        color: AppColors.secondary,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _content() {
    return Wrap(
      spacing: Dimens.vertical,
      runSpacing: Dimens.vertical,
      children: [
        _contentItem(
          money: paymentReceived.byReal(),
        ),
        _contentItem(
          itemText: Strings.receivable,
          color: AppColors.alertRedColor,
          money: paymentToReceive.byReal(),
          icon: Icons.arrow_downward_rounded,
        ),
      ],
    );
  }

  Widget _contentItem({
    IconData? icon,
    required double money,
    String itemText = Strings.received,
    Color color = AppColors.alertGreenColor,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ReportIcons(
          icon: icon,
          color: color,
        ),
        const HorizontalSpacing(
          width: 8,
        ),
        _contentDescription(
          money: money,
          itemText: itemText,
        ),
      ],
    );
  }

  Widget _contentDescription({
    required double money,
    String itemText = Strings.received,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _contentItemText(
          itemText: itemText,
          isTextEmphasis: true,
        ),
        const VerticalSpacing(
          height: 8,
        ),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Durations.transitionToNavigate,
          builder: (_, value, __) => _contentItemText(
            itemText: (money * value).formatterMoneyToBrasilian,
          ),
        ),
      ],
    );
  }

  Widget _contentItemText({
    required String itemText,
    bool isTextEmphasis = false,
  }) {
    return AutoSizeText(
      itemText,
      style: TextStyles.homeHeaderTitle.copyWith(
        color: AppColors.secondary,
        fontSize: isTextEmphasis ? 20 : 14,
        fontWeight: isTextEmphasis ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }
}
