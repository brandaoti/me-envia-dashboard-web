import 'package:flutter/material.dart';
import '../../helpers/helpers.dart';
import '../../values/values.dart';

import '../forms/forms.dart';

class EmailInputComponent extends StatelessWidget {
  final bool enabled;
  final String? labelText;
  final EdgeInsets padding;
  final EdgeInsets contentPadding;
  final FormFields? formFields;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;

  const EmailInputComponent({
    Key? key,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.onFieldSubmitted,
    required this.formFields,
    this.padding = Paddings.inputPaddingForms,
    this.labelText = Strings.emailInputLabelText,
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
        controller: formFields?.controller,
        textInputAction: TextInputAction.go,
        validator: validator ?? Validators.email,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: contentPadding,
          border: Decorations.inputBorderForms,
          disabledBorder: Decorations.inputBorderFormFocused,
          fillColor: enabled ? null : AppColors.secondary.withOpacity(0.1),
        ),
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}
