import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

import '../states/box_section_states.dart';
import '../box_section.dart';

class TabsPaymentData extends StatelessWidget {
  final HandlePressedItem onPressed;
  final BoxSectionController controller;

  const TabsPaymentData({
    Key? key,
    required this.onPressed,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _tableIds(context),
          const VerticalSpacing(
            height: 16,
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
            states.custList.sortByStatus,
            context,
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
            textAlign: TextAlign.start,
          ),
          _tableIdsText(
            flex: 3,
            textAlign: TextAlign.start,
            text: Strings.tableCustomer,
          ),
          _tableIdsText(
            text: Strings.fee,
            textAlign: TextAlign.start,
          ),
          _tableIdsText(
            flex: 2,
            text: Strings.status,
            textAlign: TextAlign.start,
            padding: const EdgeInsets.only(left: Dimens.horizontal),
          ),
        ],
      ),
    );
  }

  Widget _tableIdsText({
    int flex = 1,
    required String text,
    EdgeInsets padding = EdgeInsets.zero,
    TextAlign textAlign = TextAlign.center,
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

  Widget _content(UserPackageList customersList, BuildContext context) {
    if (customersList.isEmpty) {
      return const EmptyBoxIllustration(
        message: Strings.noBoxRequested,
      );
    }

    List<Widget> childrens = [];

    for (var i = 0; i < customersList.length; i++) {
      childrens.add(_boxData(
        index: i,
        context: context,
        customes: customersList[i],
      ));
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
    required BuildContext context,
    required UserPackage customes,
  }) {
    final bool isPar = index % 2 == 0;

    return InkWell(
      onTap: () => onPressed(customes),
      child: Container(
        height: 48,
        width: double.infinity,
        color: isPar ? AppColors.grey200 : AppColors.white,
        child: Row(
          children: [
            _leftBoxData(
              textAlign: TextAlign.start,
              text: customes.packageId.substring(0, 8),
              padding: const EdgeInsets.only(left: Dimens.horizontal24),
            ),
            _leftBoxData(
              flex: 3,
              text: customes.name,
              textAlign: TextAlign.start,
            ),
            _leftBoxItensCount(
              feeValue: customes.shippingFee?.toDouble(),
            ),
            _leftBoxLastItens(
              status: customes.status,
            ),
          ],
        ),
      ),
    );
  }

  Widget _leftBoxData({
    int flex = 1,
    String text = '',
    EdgeInsets padding = EdgeInsets.zero,
    TextAlign textAlign = TextAlign.center,
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

  Widget _leftBoxItensCount({required double? feeValue}) {
    return Expanded(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Count(
          isMoney: true,
          size: const Size(100, 28),
          backgroundColor: AppColors.secondary,
          totalValue: feeValue?.byReal().truncate() ?? 0,
          contentPadding: const EdgeInsets.symmetric(horizontal: 4),
        ),
      ),
    );
  }

  Widget _leftBoxLastItens({
    required PackageStatusType? status,
  }) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: Paddings.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _paymentStatus(
              status: status,
            ),
            const Icon(
              MdiIcons.fileEdit,
              color: AppColors.grey500,
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentStatus({
    required PackageStatusType? status,
    Alignment alignment = Alignment.center,
  }) {
    final isPending = status == null ||
        status != PackageStatusType.paymentSubjectToConfirmation;

    return Container(
      alignment: alignment,
      padding: const EdgeInsets.all(8),
      decoration: Decorations.paymenteStatus(isPending),
      constraints: const BoxConstraints(maxHeight: 34, maxWidth: 100),
      child: AutoSizeText(
        Strings.paymenteStatus(isPending),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyles.paymenteStatus(isPending),
      ),
    );
  }
}
