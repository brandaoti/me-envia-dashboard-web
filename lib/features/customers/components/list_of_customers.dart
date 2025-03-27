import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../core/components/count/count.dart';
import '../../../core/models/models.dart';
import '../../../core/values/values.dart';

class ListOfCustomers extends StatelessWidget {
  final CustomersList list;
  final ValueChanged<Customers> onPressed;

  const ListOfCustomers({
    Key? key,
    required this.list,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _header(),
        const VerticalSpacing(
          height: 16,
        ),
        _generatedCustomesItem()
      ],
    );
  }

  Widget _header() {
    return Row(
      children: [
        _headerTitle(left: 32),
        _headerTitle(
          text: Strings.itemsInStock,
        ),
      ],
    );
  }

  Widget _headerTitle({
    int flex = 1,
    double left = 0,
    String text = Strings.clientTitle,
  }) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: EdgeInsets.only(left: left),
        child: AutoSizeText(
          text,
          style: TextStyles.noConnectionTitle.copyWith(
            fontSize: 16,
            color: AppColors.secondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _generatedCustomesItem() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 410),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (_, index) {
            final customers = list[index];

            return _customesBoxItem(index, customers);
          },
        ),
      ),
    );
  }

  Widget _customesBoxItem(int index, Customers customers) {
    final bool isPar = index % 2 == 0;

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => onPressed(customers),
      child: Container(
        height: 58,
        width: double.infinity,
        child: _customesItem(customers),
        padding: Paddings.listOfCustomers,
        color: isPar ? AppColors.grey100 : AppColors.grey200,
      ),
    );
  }

  Widget _customesItem(Customers customers) {
    return Row(
      children: [
        Expanded(
          child: AutoSizeText(
            customers.name,
            maxLines: 1,
            style: TextStyles.noConnectionTitle.copyWith(
              fontSize: 14,
              color: AppColors.grey500,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          child: _actionsButton(customers),
        ),
      ],
    );
  }

  Widget _actionsButton(Customers customers) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 32),
          constraints: const BoxConstraints(maxWidth: 38, maxHeight: 20),
          child: Count(
            contentPadding: Paddings.zero,
            totalValue: customers.totalItems,
            backgroundColor: AppColors.secondary,
          ),
        ),
        const Icon(
          Icons.camera_alt_rounded,
          color: AppColors.secondary,
        ),
      ],
    );
  }
}
