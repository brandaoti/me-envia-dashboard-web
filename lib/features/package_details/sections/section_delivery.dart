import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

class SectionDelivery extends StatelessWidget {
  final Package package;

  const SectionDelivery({
    Key? key,
    required this.package,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final String title;
    late final String statusMessege;

    if (package.isPackageStock) {
      title = Strings.inStock;
      statusMessege = Strings.noStatusRegistered;
    } else {
      title = package.fullAddressAndTrackingCode;
      statusMessege = package.status ?? Strings.noStatusRegistered;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          child: _trackingCode(title: title),
          padding: const EdgeInsets.only(top: 8.0),
        ),
        _deliverySteps(statusMessege: statusMessege),
      ],
    );
  }

  Widget _trackingCode({required String title}) {
    return Row(
      children: [
        const Icon(
          Icons.pin_drop,
          size: 16,
          color: AppColors.secondaryLight,
        ),
        const HorizontalSpacing(
          width: 4,
        ),
        AutoSizeText(
          title,
          style: TextStyles.textLocationStyle,
        )
      ],
    );
  }

  Widget _deliverySteps({required String statusMessege}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: constraints.maxWidth * 0.8,
              ),
              child: AutoSizeText(
                statusMessege,
                style: TextStyles.textLocationStyle.copyWith(
                  color: AppColors.secondary,
                ),
              ),
            ),
            const VerticalSpacing(
              height: 24.0,
            ),
            _deliveryStepsWidget(
              type: package.type,
              steps: package.step,
              maxWidth: constraints.maxWidth,
            ),
          ],
        );
      },
    );
  }

  Widget _deliveryStepsWidget({
    required double maxWidth,
    required PackageType? type,
    required PackageStep? steps,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 40,
        maxWidth: maxWidth * 0.8,
      ),
      child: DeliverySteps(
        height: 20,
        type: type ?? PackageType.warning,
        steps: steps ?? PackageStep.notSend,
      ),
    );
  }
}
