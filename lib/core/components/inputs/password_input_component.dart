import 'package:flutter/material.dart';

import '../../helpers/helpers.dart';
import '../../values/values.dart';
import '../forms/forms.dart';

class PasswordInputComponent extends StatelessWidget {
  final String? labelText;
  final EdgeInsets padding;
  final String? errorText;
  final bool enabled;
  final int errorMaxLines;
  final FormFields? formFields;
  final TextInputAction? textInputAction;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;

  final bool obscureText;
  final ValueChanged<bool>? onChangedObscureText;

  const PasswordInputComponent({
    Key? key,
    this.onChanged,
    this.validator,
    this.errorText,
    this.enabled = true,
    this.onFieldSubmitted,
    this.errorMaxLines = 1,
    this.obscureText = true,
    required this.formFields,
    this.onChangedObscureText,
    this.textInputAction = TextInputAction.go,
    this.padding = Paddings.inputPaddingForms,
    this.labelText = Strings.passwordInputLabelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        enabled: enabled,
        obscureText: obscureText,
        focusNode: formFields?.focus,
        textInputAction: textInputAction,
        style: TextStyles.inputTextStyle,
        controller: formFields?.controller,
        keyboardType: TextInputType.visiblePassword,
        validator: validator ?? Validators.password,
        decoration: InputDecoration(
          labelText: labelText,
          errorText: errorText,
          suffixIcon: _suffixIcon(),
          errorMaxLines: errorMaxLines,
          border: Decorations.inputBorderForms,
          contentPadding: Paddings.inputContentPadding,
          fillColor: enabled ? null : AppColors.secondary.withOpacity(0.1),
        ),
        toolbarOptions: const ToolbarOptions(
          copy: false,
          cut: false,
          paste: false,
          selectAll: false,
        ),
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }

  Widget _suffixIcon() {
    const _mappToIcons = {
      false: Icons.visibility_off,
      true: Icons.visibility,
    };

    return IconButton(
      hoverColor: AppColors.transparent,
      splashColor: AppColors.transparent,
      onPressed: () => onChangedObscureText?.call(!obscureText),
      icon: Icon(_mappToIcons[obscureText], color: AppColors.black),
    );
  }
}
