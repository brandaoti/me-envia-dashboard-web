import 'package:flutter_modular/flutter_modular.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

import '../../components/suffix_icon_check.dart';
import '../../states/shipping_fees_state.dart';
import '../../package_details.dart';

class SectionShippingFee extends StatefulWidget {
  final String packageId;
  final double? shippingFee;
  final bool useDefaultTitle;
  final bool useDefaultLayout;
  final VoidCallback? onClose;
  final OnValidateField onValidate;

  const SectionShippingFee({
    Key? key,
    this.onClose,
    required this.onValidate,
    required this.packageId,
    required this.shippingFee,
    this.useDefaultTitle = false,
    this.useDefaultLayout = true,
  }) : super(key: key);

  @override
  _SectionShippingFeeState createState() => _SectionShippingFeeState();
}

class _SectionShippingFeeState extends State<SectionShippingFee> {
  final _freightValueFormField = FormFieldsMoney.money(leftSymbol: 'R\$');

  final _controller = Modular.get<ShippingFeeController>();

  bool _isEnableButton = false;

  @override
  void initState() {
    _controller.init(widget.shippingFee);
    _updateFormFields();
    _startListerner();
    super.initState();
  }

  void _startListerner() {
    _freightValueFormField.controller?.addListener(() {
      final value = _freightValueFormField.controller?.numberValue;

      setState(() {
        _isEnableButton = value != null && value != 0;
      });
    });

    _controller.shippingFeeStateStream.listen((states) async {
      if (states is ShippingFeeSuccessState) {
        widget.onClose?.call();
      }
    });
  }

  void _updateFormFields() {
    if (widget.shippingFee != null) {
      _freightValueFormField.controller?.updateValue(widget.shippingFee);
    }
  }

  Future<void> _handleUpdateShippingFeeValue() async {
    if (widget.onValidate()) {
      await _controller.updateShippingFeeValue(packageId: widget.packageId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.useDefaultLayout,
      child: _bodyWithDefaultLayout(),
      replacement: _bodyWithOtherLayout(),
    );
  }

  Widget _bodyWithDefaultLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(),
        const VerticalSpacing(
          height: 16.0,
        ),
        _freightValue(),
        const VerticalSpacing(
          height: 16.0,
        ),
        _saveBtn(),
      ],
    );
  }

  Widget _bodyWithOtherLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(),
        const VerticalSpacing(
          height: 8.0,
        ),
        _bodyWithOtherLayoutContent(),
      ],
    );
  }

  Widget _bodyWithOtherLayoutContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = (constraints.maxWidth / 2) - Dimens.vertical;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ConstrainedBox(
              child: _freightValue(),
              constraints: BoxConstraints(maxWidth: maxWidth),
            ),
            ConstrainedBox(
              child: _saveBtn(),
              constraints: BoxConstraints(maxWidth: maxWidth),
            ),
          ],
        );
      },
    );
  }

  Widget _freightValue() {
    return StreamBuilder<ShippingFeeState>(
      stream: _controller.shippingFeeStateStream,
      builder: (context, snapshot) {
        String? errorText;
        InputBorder? border;
        bool isIconVisiblity = false;

        final state = snapshot.data;

        if (state is ShippingFeeErrorState) {
          errorText = state.message;
        }

        if (state is ShippingFeeSuccessState) {
          isIconVisiblity = true;
          border = Decorations.outlineInputBorder;
        }

        return _shippingFeeFormField(
          border: border,
          errorText: errorText,
          isIconVisiblity: isIconVisiblity,
          isEnabled: state is! ShippingFeeSuccessState,
          isReadOnly: (state is ShippingFeeSuccessState),
        );
      },
    );
  }

  Widget _title() {
    if (widget.useDefaultTitle) {
      return const SizedBox.shrink();
    }

    return const SectionTitle(
      fontSize: 24,
      color: AppColors.grey500,
      title: Strings.shippingFee,
    );
  }

  Widget _shippingFeeFormField({
    String? errorText,
    InputBorder? border,
    bool isIconVisiblity = false,
    bool isEnabled = true,
    bool isReadOnly = false,
  }) {
    return TextFormField(
      enabled: isEnabled,
      textAlign: TextAlign.start,
      readOnly: isReadOnly,
      validator: (_) => Validators.money(
        _freightValueFormField.controller?.numberValue,
      ),
      textDirection: TextDirection.ltr,
      focusNode: _freightValueFormField.focus,
      controller: _freightValueFormField.controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: Paddings.contentPadding,
        errorMaxLines: 2,
        errorText: errorText,
        labelText: Strings.shippingFeeAmount,
        fillColor: isIconVisiblity
            ? AppColors.alertGreenColorLight.withOpacity(.3)
            : null,
        suffixIcon: Visibility(
          visible: isIconVisiblity,
          child: const SuffixIconCheck(),
        ),
        border: border,
        enabledBorder: border,
        disabledBorder: border,
        focusedBorder: border,
      ),
      onChanged: (_) {
        _controller.onChangeShippingFeeValue(
          _freightValueFormField.controller?.numberValue ?? 0,
        );
      },
      onFieldSubmitted: (_) => _handleUpdateShippingFeeValue(),
    );
  }

  Widget _saveBtn() {
    return StreamBuilder<ShippingFeeState>(
      stream: _controller.shippingFeeStateStream,
      builder: (context, snapshot) {
        final state = snapshot.data;

        final bool isValid = state is! ShippingFeeSuccessState;

        return DefaultButton(
          radius: 8,
          title: Strings.saveChangesBtn,
          isValid: isValid && _isEnableButton,
          onPressed: _handleUpdateShippingFeeValue,
          isLoading: state is ShippingFeeLoadingState,
        );
      },
    );
  }

  @override
  void dispose() {
    _freightValueFormField.dispose();
    _controller.dispose();
    super.dispose();
  }
}
