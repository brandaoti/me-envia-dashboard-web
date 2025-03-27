import 'package:flutter/material.dart';

import '../../core.dart';

class NameInputComponent extends StatelessWidget {
  final bool enabled;
  final String? labelText;
  final EdgeInsets padding;
  final FormFields? formFields;
  final EdgeInsets contentPadding;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;

  const NameInputComponent({
    Key? key,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.onFieldSubmitted,
    required this.formFields,
    this.padding = Paddings.inputPaddingForms,
    this.labelText = Strings.nameInputLabelText,
    this.contentPadding = Paddings.inputContentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        enabled: enabled,
        focusNode: formFields?.focus,
        style: TextStyles.inputTextStyle,
        keyboardType: TextInputType.text,
        controller: formFields?.controller,
        textInputAction: TextInputAction.go,
        validator: validator ?? Validators.name,
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: contentPadding,
          border: Decorations.inputBorderForms,
          fillColor: enabled ? null : AppColors.secondary.withOpacity(0.1),
        ),
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}
