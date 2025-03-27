import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../core/helpers/extensions.dart';
import '../../../core/values/values.dart';
import '../states/dollar_state.dart';
import '../../features.dart';

class DollarQuotation extends StatelessWidget {
  final VoidCallback onPressed;
  final HomeController controller;

  const DollarQuotation({
    Key? key,
    required this.onPressed,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DollarState>(
      stream: controller.dollarState,
      builder: (context, snapshot) => InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          child: _body(snapshot.data),
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(maxHeight: 56),
          decoration: Decorations.cardOrderItem(
            true,
            borderWidth: 1,
            borderRadius: 10,
            color: const Color.fromRGBO(9, 188, 138, 0.1),
          ),
        ),
      ),
    );
  }

  Widget _body(DollarState? state) {
    if (state is DollarSucessState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(),
          const VerticalSpacing(
            height: 4,
          ),
          _dollarValue(state.money),
        ],
      );
    }

    if (state is DollarErrorState) {
      return Container(
        height: 56,
        alignment: Alignment.center,
        child: _title(text: 'Alterar valor'),
      );
    }

    return Container();
  }

  Widget _title({String text = Strings.dollarOfDay}) {
    return AutoSizeText(
      text,
      style: TextStyles.homeHeaderSubtitle.copyWith(
        color: AppColors.grey500,
      ),
    );
  }

  Widget _dollarValue(double money) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AutoSizeText(
          money.formatterMoney,
          style: TextStyles.homeHeaderSubtitle.copyWith(
            fontSize: 16,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        _checkSucess(),
      ],
    );
  }

  Widget _checkSucess() {
    return Container(
      width: 18,
      height: 18,
      alignment: Alignment.center,
      child: const Icon(
        Icons.check,
        size: 14,
        color: AppColors.whiteDefault,
      ),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.alertGreenColor,
      ),
    );
  }
}
