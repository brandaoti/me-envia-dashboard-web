import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../core/helpers/helpers.dart';
import '../../../core/models/models.dart';
import '../../../core/values/values.dart';

class CustomsDeclarationItem extends StatelessWidget {
  final int index;
  final VoidCallback? onPressed;
  final Declaration declaration;

  const CustomsDeclarationItem({
    Key? key,
    this.onPressed,
    required this.index,
    required this.declaration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _itemInformation(),
      decoration: Decorations.cardOrderItem(false),
      constraints: const BoxConstraints(minWidth: 200),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: Dimens.vertical,
      ),
    );
  }

  Widget _itemInformation() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          Strings.customsDeclarationItemTitle(
            index.toString(),
            declaration.quantity.toString(),
          ),
          style: TextStyles.cardDeclarationItemTitle,
        ),
        const VerticalSpacing(
          height: 4,
        ),
        _itemInformationText(
          declaration.category,
        ),
        _itemInformationText(
          declaration.description,
        ),
        _itemInformationText(
          Strings.customsDeclarationItemValue(
            declaration.formatterUnityValue,
            false,
          ),
        ),
        _itemInformationText(
          Strings.customsDeclarationItemValue(
            declaration.formatterTotalValue,
            true,
          ),
        ),
      ],
    );
  }

  Widget _itemInformationText(String? text) {
    return SizedBox(
      width: double.infinity,
      child: AutoSizeText(
        text ?? '',
        overflow: TextOverflow.ellipsis,
        style: TextStyles.cardDeclarationItemSubtitle,
      ),
    );
  }
}
