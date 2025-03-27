import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/components.dart';
import '../../../../core/values/values.dart';

class TotalTips extends StatelessWidget {
  final int totalTips;
  final Widget addNewTipButtonWidget;

  const TotalTips({
    Key? key,
    required this.totalTips,
    required this.addNewTipButtonWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _content(),
        addNewTipButtonWidget,
      ],
    );
  }

  Widget _content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _title(),
            const HorizontalSpacing(
              width: 8,
            ),
            _boxItensCount(),
          ],
        ),
        const VerticalSpacing(
          height: 8,
        ),
        _subtitle()
      ],
    );
  }

  Widget _title() {
    return const AutoSizeText(
      Strings.mariaTipsHeaderTitle,
      style: TextStyles.requestedBoxTitle,
    );
  }

  Widget _subtitle() {
    return const AutoSizeText(
      Strings.mariaTipsHeaderSubtitle,
      textAlign: TextAlign.start,
      style: TextStyle(
        fontSize: 18,
        color: AppColors.secondary,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _boxItensCount() {
    return SizedBox(
      width: 40,
      child: Count(totalValue: totalTips),
    );
  }
}
