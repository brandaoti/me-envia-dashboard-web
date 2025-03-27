import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import 'card_items.dart';

typedef ListOfChanged = void Function(List);

class ListOfItems extends StatelessWidget {
  final BoxList list;
  final bool isVisibleButton;
  final ListOfChanged? onView;
  final VoidCallback? onCreateNewItem;

  const ListOfItems({
    Key? key,
    required this.list,
    required this.onView,
    this.isVisibleButton = true,
    required this.onCreateNewItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(),
        const VerticalSpacing(
          height: 14,
        ),
        _listOfItems(),
      ],
    );
  }

  Widget _header() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _itemsInStock(),
            const HorizontalSpacing(
              width: 8,
            ),
            SizedBox(
              width: 38,
              child: Count(
                totalValue: list.length,
                contentPadding: Paddings.zero,
              ),
            ),
          ],
        ),
        Visibility(
          visible: isVisibleButton,
          child: _addItemButton(),
        ),
      ],
    );
  }

  Widget _itemsInStock() {
    return const AutoSizeText(
      Strings.itemsInStock,
      style: TextStyles.customersHeaderSubtitle,
    );
  }

  Widget _addItemButton() {
    return Container(
      constraints: Sizes.addItemButton,
      child: DefaultButton(
        isValid: true,
        fontSize: 14,
        onPressed: onCreateNewItem,
        title: Strings.addItem,
      ),
    );
  }

  Widget _listOfItems() {
    if (list.isEmpty) {
      return const EmptyBoxIllustration(
        message: Strings.noItemsRegistrationInStock,
      );
    }

    List<Widget> children = [];

    for (int index = 0; index < list.length; index++) {
      children.add(_createdItem(
        index: index,
        box: list[index],
      ));
    }

    return Container(
      child: Column(
        children: children,
        mainAxisAlignment: MainAxisAlignment.start,
      ),
      padding: Paddings.allDefaultSmall,
      decoration: Decorations.cardOrderItem(false),
    );
  }

  Widget _createdItem({
    required int index,
    required Box box,
  }) {
    return CardItems(
      box: box,
      index: index + 1,
      onPressed: () => onView?.call([index + 1, box]),
    );
  }
}
