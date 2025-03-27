import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

import '../../create_items/components/card_items.dart';
import '../components/section_title_texts.dart';

class SectionPackageItem extends StatelessWidget {
  final BoxList packageList;
  final double? fontSize;

  const SectionPackageItem({
    Key? key,
    required this.packageList,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(),
        const VerticalSpacing(
          height: 8,
        ),
        _scrollBar(context),
      ],
    );
  }

  Widget _scrollBar(BuildContext context) {
    return Theme(
      data: AppTheme.scrollTheme(context),
      child: Scrollbar(
        thickness: 7,
        radius: const Radius.circular(20),
        child: _packageItemList(context),
      ),
    );
  }

  Widget _packageItemList(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 500,
        maxHeight: Dimens.packageItemMaxHeight,
      ),
      decoration: Decorations.cardOrderItem(false),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: packageList.length,
        itemBuilder: (_, index) {
          final box = packageList[index];

          return CardItems(box: box, index: index + 1);
        },
      ),
    );
  }

  Widget _title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SectionTitle(
          title: Strings.packageItemText,
        ),
        const HorizontalSpacing(
          width: 8,
        ),
        Count(
          totalValue: packageList.length,
        )
      ],
    );
  }
}
