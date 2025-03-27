import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../core/helpers/extensions.dart';
import '../../../core/models/models.dart';
import '../../../core/values/values.dart';

class CardMariaTipsComponent extends StatelessWidget {
  final VoidCallback onTap;
  final MariaTips mariaTips;

  const CardMariaTipsComponent({
    Key? key,
    required this.onTap,
    required this.mariaTips,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: _card(),
      ),
      padding: const EdgeInsets.only(bottom: 24),
    );
  }

  Widget _card() {
    return Container(
      decoration: Decorations.cardOrderItem(false),
      child: Column(
        children: [
          const VerticalSpacing(
            height: 10,
          ),
          _header(),
          _content(),
          const VerticalSpacing(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: Paddings.mariaTipsCardPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _title(),
          ),
          const Icon(
            MdiIcons.pencil,
            color: AppColors.secondary,
          )
        ],
      ),
    );
  }

  Widget _title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          mariaTips.title ?? '',
          maxLines: 2,
          style: TextStyles.mariaTipsTitle.copyWith(fontSize: 18),
        ),
        const VerticalSpacing(
          height: 8,
        ),
        AutoSizeText(
          mariaTips.createdAt.toMonthAndDay,
          textAlign: TextAlign.start,
          style: TextStyles.mariaTipsCardDate,
        ),
      ],
    );
  }

  Widget _content() {
    return Container(
      width: double.infinity,
      padding: Paddings.horizontal,
      child: AutoSizeText(
        mariaTips.description ?? '',
        maxLines: 3,
        minFontSize: 14,
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        style: TextStyles.mariaTipsTitle.copyWith(
          fontSize: 16,
          color: AppColors.secondary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
