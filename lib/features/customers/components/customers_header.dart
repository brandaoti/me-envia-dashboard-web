import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

class CustomersHeader extends StatelessWidget {
  final int totalValue;

  const CustomersHeader({
    Key? key,
    required this.totalValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const VerticalSpacing(
          height: 16,
        ),
        _titleAndTotalClientItems(),
        const VerticalSpacing(
          height: 8,
        ),
        _subtitle()
      ],
    );
  }

  Widget _titleAndTotalClientItems() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _title(),
        const HorizontalSpacing(
          width: 8,
        ),
        Visibility(
          visible: totalValue >= 1,
          child: Padding(
            child: Count(totalValue: totalValue),
            padding: const EdgeInsets.only(top: 8),
          ),
        ),
      ],
    );
  }

  Widget _title() {
    return const AutoSizeText(
      Strings.clientTitle,
      style: TextStyles.sectionHeaderTitleStyle,
    );
  }

  Widget _subtitle() {
    return AutoSizeText(
      Strings.followYourRegisteredCustomers,
      style: TextStyles.homeHeaderSubtitle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.secondaryTextLight,
      ),
    );
  }
}
