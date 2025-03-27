import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/count/count.dart';
import '../../../../core/values/values.dart';
import 'total_itens_controller.dart';

class TotalItens extends StatelessWidget {
  final TotalItemsController controller;

  const TotalItens({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const VerticalSpacing(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _title(),
            const HorizontalSpacing(width: 8),
            // _boxItensCount(),
          ],
        ),
        const VerticalSpacing(height: 8),
        _subtitle()
      ],
    );
  }

  Widget _subtitle() {
    return const AutoSizeText(
      Strings.requestedBoxSubtitle,
      minFontSize: 12,
      textAlign: TextAlign.left,
      style: TextStyles.requestedBoxSubtitle,
    );
  }

  Widget _title() {
    return const AutoSizeText(
      Strings.requestedBoxTitle,
      maxFontSize: 28,
      minFontSize: 20,
      style: TextStyles.requestedBoxTitle,
    );
  }

  // ignore: unused_element
  Widget _boxItensCount() {
    return StreamBuilder<int?>(
      stream: controller.itensCountStream,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container();
        }
        return SizedBox(
          width: 48,
          child: Count(
            contentPadding: const EdgeInsets.symmetric(horizontal: 6),
            totalValue: snapshot.data!,
          ),
        );
      },
    );
  }
}
