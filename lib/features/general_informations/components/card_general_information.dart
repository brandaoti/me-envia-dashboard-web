import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/values/values.dart';

class CardGeneralInformation extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onEditInformation;

  const CardGeneralInformation({
    Key? key,
    required this.title,
    required this.message,
    required this.onEditInformation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _content(),
      width: double.infinity,
      padding: Paddings.allDefault,
      decoration: Decorations.cardOrderItem(false),
    );
  }

  Widget _content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(),
        const VerticalSpacing(
          height: 10.0,
        ),
        Expanded(
          child: _subtitle(),
        ),
      ],
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: AutoSizeText(
            title,
            style: TextStyles.cardInformationTitle.copyWith(),
          ),
        ),
        IconButton(
          padding: Paddings.zero,
          onPressed: onEditInformation,
          icon: const Icon(
            MdiIcons.pencil,
            color: AppColors.secondary,
          ),
        )
      ],
    );
  }

  Widget _subtitle() {
    return AutoSizeText(
      message,
      maxLines: 5,
      minFontSize: 16,
      overflow: TextOverflow.ellipsis,
      style: TextStyles.cardInformationSubtitle,
    );
  }
}
