import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../features.dart';

import '../states/box_section_states.dart';
import 'modal_add_shipping_fee.dart';

class TabsData extends StatelessWidget {
  final HandlePressedItem onPressed;
  final BoxSectionController controller;

  const TabsData({
    Key? key,
    required this.onPressed,
    required this.controller,
  }) : super(key: key);

  void _showModalAddShippingFee(
    String packageId,
    String itemCount,
    double? shippingFee,
    BuildContext context,
  ) {
    ModalAddShippingFee(
      context: context,
      packageId: packageId,
      itemCount: itemCount,
      shippingFee: shippingFee,
      onClosed: () => controller.init(UserParameters.created),
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _tableIds(context),
          const VerticalSpacing(
            height: 18,
          ),
          _body(),
        ],
      ),
    );
  }

  Widget _body() {
    return StreamBuilder<BoxSectionState>(
      stream: controller.boxSectionStateStream,
      builder: (context, snapshot) {
        final states = snapshot.data;

        if (states is BoxSectionLoadingState) {
          return _loading();
        }

        if (states is BoxSectionSucessState) {
          return _content(
            context: context,
            customersList: states.custList,
          );
        }

        if (states is BoxSectionErrorState) {
          return _errorState(states.message);
        }

        return Container();
      },
    );
  }

  Widget _errorState(String? message) {
    return Center(
      child: ErrorText(
        icon: null,
        fontSize: 24,
        message: message,
        isConfirmError: false,
      ),
    );
  }

  Widget _loading() {
    return const Center(
      child: Loading(
        height: 460,
        useContainerBox: true,
      ),
    );
  }

  Widget _tableIds(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          _tableIdsText(
            text: Strings.boxId,
          ),
          _tableIdsText(
            flex: 2,
            text: Strings.tableCustomer,
          ),
          _tableIdsText(
            flex: 3,
            text: Strings.tableItens,
          ),
        ],
      ),
    );
  }

  Widget _tableIdsText({
    int flex = 1,
    required String text,
    EdgeInsets padding = EdgeInsets.zero,
    TextAlign textAlign = TextAlign.start,
  }) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: padding,
        child: AutoSizeText(
          text,
          minFontSize: 14,
          textAlign: textAlign,
          style: TextStyles.tableTitles,
        ),
      ),
    );
  }

  Widget _content({
    required BuildContext context,
    required UserPackageList customersList,
  }) {
    if (customersList.isEmpty) {
      return const EmptyBoxIllustration();
    }

    List<Widget> childrens = [];

    for (var i = 0; i < customersList.length; i++) {
      childrens.add(
        _boxData(
          context: context,
          index: i,
          customers: customersList[i],
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Column(
        children: childrens,
      ),
    );
  }

  Widget _boxData({
    required int index,
    required UserPackage customers,
    required BuildContext context,
  }) {
    final bool isPar = index % 2 == 0;

    return InkWell(
      onTap: () => onPressed(customers),
      child: Container(
        height: 48,
        width: double.infinity,
        color: isPar ? AppColors.grey200 : AppColors.white,
        child: Row(
          children: [
            _leftBoxData(
              textAlign: TextAlign.start,
              text: customers.packageId.substring(0, 8),
              padding: const EdgeInsets.only(left: Dimens.horizontal24),
            ),
            _leftBoxData(
              flex: 2,
              text: customers.name,
            ),
            _leftBoxLastItens(
              context: context,
              customers: customers,
              padding: const EdgeInsets.only(right: Dimens.horizontal24),
            )
          ],
        ),
      ),
    );
  }

  Widget _leftBoxData({
    int flex = 1,
    String text = '',
    EdgeInsets padding = EdgeInsets.zero,
    TextAlign textAlign = TextAlign.start,
  }) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: padding,
        child: AutoSizeText(
          text,
          minFontSize: 12,
          textAlign: textAlign,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _leftBoxLastItens({
    int flex = 3,
    required UserPackage customers,
    required BuildContext context,
    EdgeInsets padding = EdgeInsets.zero,
  }) {
    final String? totalValue = customers.count;
    return Expanded(
      flex: flex,
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _boxItensCount(
              totalValue: totalValue != null ? int.parse(totalValue) : 0,
            ),
            const Icon(
              MdiIcons.fileEdit,
              color: AppColors.grey500,
            ),
            _addShippingFeeButton(customers: customers, context: context),
          ],
        ),
      ),
    );
  }

  Widget _boxItensCount({required int totalValue}) {
    return Count(
      totalValue: totalValue,
      size: const Size(48, 24),
      backgroundColor: AppColors.secondary,
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
    );
  }

  Widget _addShippingFeeButton({
    required UserPackage customers,
    required BuildContext context,
  }) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 120,
        maxHeight: 34,
      ),
      child: DefaultButton(
        radius: 8,
        isValid: true,
        fontSize: 14,
        minFontSize: 14,
        title: Strings.insertFee,
        onPressed: () => _showModalAddShippingFee(
          customers.packageId,
          customers.count ?? '0',
          customers.shippingFee?.toDouble() ?? 0,
          context,
        ),
      ),
    );
  }
}
