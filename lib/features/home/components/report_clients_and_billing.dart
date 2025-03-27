import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/helpers/extensions.dart';
import '../../../core/values/values.dart';
import 'components.dart';

class ReportClientsAndBilling extends StatelessWidget {
  final double billing;
  final int totalCustomers;

  const ReportClientsAndBilling({
    Key? key,
    required this.billing,
    required this.totalCustomers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        spacing: Dimens.vertical,
        runSpacing: Dimens.vertical,
        alignment: WrapAlignment.spaceBetween,
        children: [
          _content(
            context: context,
            icon: Icons.person,
            count: totalCustomers,
            color: AppColors.chartOrangeColor,
            text: Strings.navBarScreenNames[2],
          ),
          _content(
            context: context,
            count: billing,
            text: Strings.revenues,
            color: AppColors.chartPupleColor,
            icon: Icons.attach_money_rounded,
          ),
        ],
      ),
    );
  }

  Widget _content({
    required num count,
    required String text,
    required Color color,
    required IconData icon,
    required BuildContext context,
  }) {
    return Visibility(
      visible: context.screenWidth >= 1500,
      replacement: _contentMobile(
        count: count,
        text: text,
        color: color,
        icon: icon,
      ),
      child: _contentDesktop(
        count: count,
        text: text,
        color: color,
        icon: icon,
      ),
    );
  }

  Widget _contentMobile({
    required num count,
    required String text,
    required Color color,
    required IconData icon,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        constraints: constraints,
        padding: Paddings.allDefaultSmall,
        width: (constraints.maxWidth / 2) - 8,
        decoration: Decorations.cardOrderItem(false),
        child: _contentItem(
          count: count,
          text: text,
          color: color,
          icon: icon,
          maxHeight: 26,
        ),
      ),
    );
  }

  Widget _contentDesktop({
    required num count,
    required String text,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      padding: Paddings.allDefaultSmall,
      decoration: Decorations.cardOrderItem(false),
      child: _contentItem(count: count, text: text, color: color, icon: icon),
    );
  }

  Widget _contentItem({
    required num count,
    required String text,
    required Color color,
    required IconData icon,
    double maxHeight = double.infinity,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ReportIcons(
          icon: icon,
          color: color,
        ),
        const VerticalSpacing(
          height: 16,
        ),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Durations.transitionToNavigate,
          builder: (_, value, __) => _text(
            isTextEmphasis: true,
            maxHeight: maxHeight,
            itemText: (count * value).toInt().formatterMoneyNoSimbol,
          ),
        ),
        const VerticalSpacing(
          height: 16,
        ),
        _text(itemText: text),
      ],
    );
  }

  Widget _text({
    required String itemText,
    bool isTextEmphasis = false,
    double maxHeight = double.infinity,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: maxHeight,
        maxWidth: double.infinity,
      ),
      child: AutoSizeText(
        itemText,
        maxLines: 1,
        minFontSize: 12,
        textAlign: TextAlign.start,
        style: TextStyles.homeHeaderTitle.copyWith(
          color: AppColors.secondary,
          fontSize: isTextEmphasis ? 38 : 20,
          fontWeight: isTextEmphasis ? FontWeight.w900 : FontWeight.w600,
        ),
      ),
    );
  }
}
