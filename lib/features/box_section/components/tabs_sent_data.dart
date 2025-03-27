import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../box_section_controller.dart';
import '../box_section_screen.dart';
import '../states/box_section_states.dart';
import 'modal_add_tracking_code.dart';

class TabsSentData extends StatelessWidget {
  final HandlePressedItem onPressed;
  final BoxSectionController controller;

  const TabsSentData({
    Key? key,
    required this.onPressed,
    required this.controller,
  }) : super(key: key);

  void _showModalAddTrackingCode(
      String packageId, String? trackingCode, BuildContext context) {
    ModalAddTrackingCode(
      context: context,
      packageId: packageId,
      trackingCode: trackingCode,
      onClosed: () => controller.init(UserParameters.sent),
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SingleChildScrollView(
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
          return _content(states.custList.sortByWithTrackingCode, context);
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
            flex: 3,
            text: Strings.tableCustomer,
          ),
          _tableIdsText(
            text: Strings.trackingCode,
          ),
          _tableIdsText(
            flex: 3,
            text: Strings.tracking,
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

  Widget _content(UserPackageList customersList, BuildContext context) {
    if (customersList.isEmpty) {
      return const EmptyBoxIllustration(
        message: Strings.noSentBox,
      );
    }

    List<Widget> childrens = [];

    for (var i = 0; i < customersList.length; i++) {
      childrens.add(_boxData(
        isPar: i % 2 == 0,
        context: context,
        customers: customersList[i],
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
    required bool isPar,
    required BuildContext context,
    required UserPackage customers,
  }) {
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
              flex: 3,
              text: customers.name,
            ),
            _checkBoxButton(
              isEnabled: customers.trackingCode != null,
            ),
            _leftBoxLastItens(customers: customers, context: context)
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

  Widget _checkBoxButton({required bool isEnabled}) {
    const Map<bool, IconData> mappinState = {
      true: Icons.check_box,
      false: Icons.check_box_outline_blank_rounded,
    };

    return Expanded(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Icon(
          mappinState[isEnabled],
          color: isEnabled ? AppColors.alertGreenColor : AppColors.grey400,
        ),
      ),
    );
  }

  Widget _leftBoxLastItens(
      {required UserPackage customers, required BuildContext context}) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.only(right: Dimens.horizontal),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _deliverySteps(
              type: customers.type,
              steps: customers.step,
            ),
            const Icon(
              MdiIcons.fileEdit,
              color: AppColors.grey500,
            ),
            _addTrackingCodeBtn(customers: customers, context: context)
          ],
        ),
      ),
    );
  }

  Widget _deliverySteps({
    required PackageType? type,
    required PackageStep? steps,
  }) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 80,
        maxHeight: 20,
      ),
      child: DeliverySteps(
        height: 20,
        type: type ?? PackageType.success,
        steps: steps ?? PackageStep.notSend,
      ),
    );
  }

  Widget _addTrackingCodeBtn(
      {required UserPackage customers, required BuildContext context}) {
    const constraints = BoxConstraints(
      maxWidth: 120,
      maxHeight: 34,
    );

    if (customers.trackingCode != null) {
      return SizedBox(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
      );
    }

    return ConstrainedBox(
      constraints: constraints,
      child: DefaultButton(
        radius: 8,
        fontSize: 14,
        isValid: true,
        minFontSize: 14,
        title: Strings.insertCode,
        onPressed: () => _showModalAddTrackingCode(
            customers.packageId, customers.trackingCode, context),
      ),
    );
  }
}
