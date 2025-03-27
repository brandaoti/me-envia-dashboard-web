import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../core/values/values.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(),
        const VerticalSpacing(
          height: 8,
        ),
        _subtitle(),
      ],
    );
  }

  Widget _title() {
    return const AutoSizeText(
      Strings.helloAdm,
      style: TextStyles.homeHeaderTitle,
    );
  }

  Widget _subtitle() {
    return const AutoSizeText(
      Strings.welcomeShippingManager,
      style: TextStyles.homeHeaderSubtitle,
    );
  }
}
