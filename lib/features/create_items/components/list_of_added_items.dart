import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

import '../states/create_customers_items_state.dart';
import '../models/customer_items.dart';

class ListOfAddedIitems extends StatelessWidget {
  final VoidCallback onFinish;
  final VoidCallback onAddNewItem;
  final List<CustomersItem> items;
  final ValueChanged<CustomersItem> onEditItem;
  final Stream<CreateCustomersItemsState> createCustomersItemsStream;

  const ListOfAddedIitems({
    Key? key,
    required this.onFinish,
    required this.onAddNewItem,
    required this.items,
    required this.onEditItem,
    required this.createCustomersItemsStream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _body()),
        _actionsButton(),
      ],
    );
  }

  Widget _body() {
    return ListView(
      shrinkWrap: true,
      children: [
        _title(),
        const VerticalSpacing(
          height: 48,
        ),
        _listOfItems(),
      ],
    );
  }

  Widget _actionsButton() {
    return Column(
      children: [
        const VerticalSpacing(
          height: 16,
        ),
        _addNewItemButton(),
        const VerticalSpacing(
          height: 16,
        ),
        _finishButton(),
        const VerticalSpacing(
          height: 16,
        ),
      ],
    );
  }

  Widget _title() {
    return SizedBox(
      width: double.infinity,
      child: AutoSizeText(
        Strings.addeItems,
        textAlign: TextAlign.center,
        style: TextStyles.noConnectionTitle.copyWith(
          fontSize: 38,
          color: AppColors.secondary,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _listOfItems() {
    final List<Widget> children = [];

    for (int index = 0; index < items.length; index++) {
      children.add(Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: _itemContainer(index: index, item: items[index]),
      ));
    }

    return Column(
      children: children,
    );
  }

  Widget _itemContainer({
    required CustomersItem item,
    required int index,
  }) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: _contentItem(item, index),
      padding: Paddings.allDefaultSmall,
      decoration: Decorations.cardOrderItem(false),
      constraints: const BoxConstraints(maxHeight: 88),
    );
  }

  Widget _contentItem(CustomersItem item, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _photo(item.file),
        Expanded(
          child: _itemName(index + 1, item.name),
        ),
        _editIcon(() => onEditItem(item)),
      ],
    );
  }

  Widget _photo(PutFileImage? putFileImage) {
    ImageProvider? image;

    if (putFileImage != null) {
      image = MemoryImage(putFileImage.bytes!);
    }

    return CircleAvatar(
      backgroundImage: image,
      maxRadius: Dimens.itemsRadius,
      minRadius: Dimens.itemsRadius,
      backgroundColor: AppColors.grey300,
    );
  }

  Widget _itemName(int index, String? name) {
    return Padding(
      padding: Paddings.horizontalSmall,
      child: AutoSizeText(
        (name ?? '').isEmpty ? 'Foto $index' : name,
        textAlign: TextAlign.left,
        style: TextStyles.noConnectionTitle.copyWith(
          fontSize: 18,
          color: AppColors.secondary,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _editIcon(
    VoidCallback callback,
  ) {
    return IconButton(
      onPressed: callback,
      padding: Paddings.zero,
      icon: const Icon(Icons.edit, color: Colors.black),
    );
  }

  Widget _addNewItemButton() {
    return RoundedButton(
      isValid: true,
      onPressed: onAddNewItem,
      title: Strings.addeNewItems,
    );
  }

  Widget _finishButton() {
    return StreamBuilder<CreateCustomersItemsState>(
      stream: createCustomersItemsStream,
      builder: (context, snapshot) => DefaultButton(
        onPressed: onFinish,
        isValid: items.isNotEmpty,
        title: Strings.finishRegistration,
        isLoading: snapshot.data is CreateCustomersItemsLoadingState,
      ),
    );
  }
}
