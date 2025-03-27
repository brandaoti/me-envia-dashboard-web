import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

import '../../package_details/states/load_package_itens_state.dart';
import '../../package_details/states/shipping_fees_state.dart';
import '../../package_details/package_details.dart';

class ModalAddShippingFee {
  final double? shippingFee;
  final VoidCallback? onClosed;
  final BuildContext context;
  final String packageId;
  final String itemCount;

  final _controller = Modular.get<ShippingFeeController>();
  final _formKey = GlobalKey<FormState>();

  ModalAddShippingFee({
    required this.shippingFee,
    this.onClosed,
    required this.context,
    required this.packageId,
    required this.itemCount,
  });

  void show() {
    _controller.init(0, packageId: packageId);
    showDialog(
      context: context,
      builder: _builder,
    );
  }

  void _dispose() {
    Navigator.pop(context);
    _controller.dispose();
    onClosed?.call();
  }

  Widget _builder(
    BuildContext context,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        child: _body(),
        constraints: Sizes.modalMaxWidth(),
        padding: Paddings.modalCreateNewFaq,
      ),
    );
  }

  Widget _body() {
    return StreamBuilder<Object>(
      stream: _controller.shippingFeeStateStream,
      builder: (context, snapshot) {
        final states = snapshot.data;

        return Visibility(
          replacement: _content(),
          child: const ModalEditingCompleted(),
          visible: states is ShippingFeeSuccessState,
        );
      },
    );
  }

  Widget _content() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const AutoSizeText(
            Strings.addFee,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: AppColors.secondary,
            ),
          ),
          const VerticalSpacing(
            height: 9,
          ),
          Row(
            children: [
              const AutoSizeText(
                Strings.itemsInBox,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.grey500,
                ),
              ),
              const HorizontalSpacing(
                width: 5,
              ),
              _modalBoxItensCount(itemCount),
            ],
          ),
          const VerticalSpacing(
            height: 16,
          ),
          _listOfPackageItens(),
          const VerticalSpacing(
            height: 16,
          ),
          SectionShippingFee(
            onClose: _dispose,
            packageId: packageId,
            shippingFee: shippingFee,
            onValidate: () => _formKey.currentState?.validate() ?? false,
          ),
        ],
      ),
    );
  }

  Widget _listOfPackageItens() {
    return StreamBuilder<LoadPackageItensState>(
      stream: _controller.loadPackageItensStateStream,
      builder: (context, snapshot) {
        final states = snapshot.data;

        if (states is LoadPackageItensLoadingState ||
            states is LoadPackageItensErrorState) {
          return const Loading(
            useContainerBox: true,
          );
        }

        if (states is LoadPackageItensSuccessState) {
          return _listOfItens(states.boxList);
        }

        return Container();
      },
    );
  }

  Widget _listOfItens(BoxList boxList) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 200,
      ),
      child: ListView.separated(
        itemCount: boxList.length,
        itemBuilder: (context, index) => PackageCard(
          box: boxList[index],
          index: index + 1,
        ),
        separatorBuilder: (context, index) => const VerticalSpacing(
          height: Dimens.vertical,
        ),
      ),
    );
  }

  Widget _modalBoxItensCount(String count) {
    return Container(
      width: 43,
      height: 15,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: AutoSizeText(
        count,
        minFontSize: 12,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColors.whiteDefault,
        ),
      ),
    );
  }
}
