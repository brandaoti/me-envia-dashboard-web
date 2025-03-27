import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/components/components.dart';
import '../../../core/helpers/helpers.dart';
import '../../../core/values/values.dart';
import '../states/dollar_state.dart';
import '../../features.dart';

class ModalUpdateDollar {
  final BuildContext context;
  final HomeController controller;

  final _formKey = GlobalKey<FormState>();
  final _moneyTextController = MoneyMaskedTextController(leftSymbol: 'U\$ ');

  ModalUpdateDollar({
    required this.context,
    required this.controller,
  });

  void show() {
    showDialog(
      context: context,
      builder: _builder,
    );
  }

  Widget _builder(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.whiteDefault,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: Paddings.allDefault,
        constraints: const BoxConstraints(maxWidth: 640),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AutoSizeText(
                Strings.addQuoteOfDay,
                textAlign: TextAlign.start,
                style: TextStyles.dollarQuotationModalTitle,
              ),
              const VerticalSpacing(
                height: 24,
              ),
              _dollarFormField(),
              const VerticalSpacing(
                height: 16,
              ),
              _defaultButton(),
              const VerticalSpacing(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dollarFormField() {
    return StreamBuilder<DollarState>(
      stream: controller.dollarState,
      builder: (context, snapshot) {
        String? errorText;
        final state = snapshot.data;

        if (state is DollarErrorState) {
          errorText = state.message;
        }

        return TextFormField(
          controller: _moneyTextController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            filled: true,
            errorText: errorText,
            labelText: Strings.quoteLabelText,
            labelStyle: TextStyles.labelStyle,
            border: Decorations.inputBorderForms,
            fillColor: const Color(0xffCBCDDE).withOpacity(0.2),
          ),
          validator: (value) {
            return Validators.money(_moneyTextController.numberValue);
          },
          onFieldSubmitted: (_) => _handleAddNewDollarQuotation(),
        );
      },
    );
  }

  void _handleAddNewDollarQuotation() async {
    final bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    final money = _moneyTextController.numberValue;
    await controller.createNewQuotation(money);

    _closed();
  }

  Widget _defaultButton() {
    return StreamBuilder<DollarState>(
      stream: controller.dollarState,
      builder: (context, snapshot) => DefaultButton(
        isValid: true,
        title: Strings.finishRegistration,
        onPressed: _handleAddNewDollarQuotation,
        isLoading: snapshot.data is DollarLoadingState,
      ),
    );
  }

  void _closed() {
    Navigator.of(context).pop();
  }
}
