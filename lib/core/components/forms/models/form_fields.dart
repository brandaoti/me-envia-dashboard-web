import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter/material.dart';

class FormFields {
  final FocusNode? focus;
  final TextEditingController? controller;

  FormFields({
    FocusNode? focus,
    TextEditingController? controller,
  })  : focus = focus ?? FocusNode(),
        controller = controller ?? TextEditingController();

  factory FormFields.mask({String? mask}) {
    return FormFields(
      focus: FocusNode(),
      controller: MaskedTextController(mask: mask),
    );
  }
  String? get getText => controller?.value.text;

  String? get getMaskValue => controller?.value.text;

  void dispose() {
    focus?.dispose();
    controller?.dispose();
  }
}

class FormFieldFormatter extends FormFields {
  final MaskTextInputFormatter formatter;

  FormFieldFormatter({
    FocusNode? focus,
    TextEditingController? controller,
    required this.formatter,
  });

  factory FormFieldFormatter.mask({String? mask}) {
    return FormFieldFormatter(
      formatter: MaskTextInputFormatter(mask: mask),
    );
  }

  @override
  String? get getMaskValue => formatter.getMaskedText();
}

class FormFieldsMoney extends FormFields {
  @override
  // ignore: overridden_fields
  final MoneyMaskedTextController? controller;

  FormFieldsMoney({
    FocusNode? focus,
    MoneyMaskedTextController? controller,
  })  : controller = controller ?? MoneyMaskedTextController(),
        super(controller: controller);

  factory FormFieldsMoney.money({String? leftSymbol = 'U\$'}) {
    return FormFieldsMoney(
      focus: FocusNode(),
      controller: MoneyMaskedTextController(leftSymbol: leftSymbol),
    );
  }

  @override
  String? get getMaskValue => controller?.value.text;

  @override
  void dispose() {
    focus?.dispose();
    controller?.dispose();
  }
}
