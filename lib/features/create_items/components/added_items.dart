import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../../../core/values/values.dart';

class AddedItems extends StatelessWidget {
  const AddedItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _illustration(),
        const VerticalSpacing(
          height: 64,
        ),
        _title(),
        const VerticalSpacing(
          height: 16,
        ),
        _subtitle(),
      ],
    );
  }

  Widget _title() {
    return const SizedBox(
      width: double.infinity,
      child: AutoSizeText(
        Strings.itemsAdded,
        textAlign: TextAlign.center,
        style: TextStyles.noConnectionTitle,
      ),
    );
  }

  Widget _subtitle() {
    return SizedBox(
      width: double.infinity,
      child: AutoSizeText(
        Strings.itemAddedMessage,
        textAlign: TextAlign.center,
        style: TextStyles.forgotPasswordContent.copyWith(
          color: AppColors.black,
        ),
      ),
    );
  }

  Widget _illustration() {
    return SvgPicture.asset(
      Svgs.forgotPassword02,
      width: 300,
      height: 300,
    );
  }
}
