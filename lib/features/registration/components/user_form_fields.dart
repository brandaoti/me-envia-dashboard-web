import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../core/components/components.dart';
import '../../../core/helpers/helpers.dart';
import '../../../core/values/values.dart';
import '../types/types.dart';
import 'components.dart';

class UserFormFields extends StatefulWidget {
  final bool isLoading;
  final Widget errorWidget;
  final Widget headerWidget;
  final VoidCallback onSubmitted;
  final UserFormFieldsController controller;

  const UserFormFields({
    Key? key,
    required this.isLoading,
    required this.controller,
    required this.onSubmitted,
    required this.headerWidget,
    required this.errorWidget,
  }) : super(key: key);

  @override
  _UserFormFieldsState createState() => _UserFormFieldsState();
}

class _UserFormFieldsState extends State<UserFormFields> {
  final _nameFormFields = FormFields();
  final _emailFormFields = FormFields();
  final _passwordFormFields = FormFields();
  final _securityCodeFormFields = FormFields();
  final _passwordConfirmFormFields = FormFields();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.headerWidget,
        const VerticalSpacing(
          height: 24,
        ),
        _name(),
        _email(),
        _securityCode(),
        _statePasswordVisible(),
        const VerticalSpacing(
          height: 40,
        ),
        widget.errorWidget,
        _onSubmittedButton(),
      ],
    );
  }

  Widget _name() {
    return NameInputComponent(
      enabled: !widget.isLoading,
      padding: Paddings.regsitartionFormFiels,
      formFields: _nameFormFields,
      onChanged: (String? value) {
        widget.controller.onFormChanged(UserFormType.name, value ?? '');
      },
      onFieldSubmitted: (_) {
        _emailFormFields.focus?.requestFocus();
      },
    );
  }

  Widget _email() {
    return EmailInputComponent(
      enabled: !widget.isLoading,
      formFields: _emailFormFields,
      padding: Paddings.regsitartionFormFiels,
      onChanged: (String? value) {
        widget.controller.onFormChanged(UserFormType.email, value ?? '');
      },
      onFieldSubmitted: (_) {
        _securityCodeFormFields.focus?.requestFocus();
      },
    );
  }

  Widget _securityCode() {
    return NameInputComponent(
      enabled: !widget.isLoading,
      formFields: _securityCodeFormFields,
      labelText: Strings.codeInputLabelText,
      padding: Paddings.regsitartionFormFiels,
      onChanged: (String? value) {
        widget.controller.onFormChanged(UserFormType.securityCode, value ?? '');
      },
      onFieldSubmitted: (_) {
        _passwordFormFields.focus?.requestFocus();
      },
    );
  }

  Widget _statePasswordVisible() {
    return StreamBuilder<bool>(
      stream: widget.controller.isPasswordVisibleStream,
      builder: (context, snapshot) {
        final bool isPasswordVisible = snapshot.data ?? true;
        return Column(
          children: [
            _password(isPasswordVisible),
            _passwordConfirmation(isPasswordVisible),
          ],
        );
      },
    );
  }

  Widget _password(bool isPasswordVisible) {
    return PasswordInputComponent(
      enabled: !widget.isLoading,
      obscureText: isPasswordVisible,
      formFields: _passwordFormFields,
      padding: Paddings.regsitartionFormFiels,
      onChangedObscureText: widget.controller.togglePasswordVisible,
      onChanged: (value) {
        widget.controller.onFormChanged(UserFormType.password, value ?? '');
      },
      onFieldSubmitted: (_) {
        _passwordConfirmFormFields.focus?.requestFocus();
      },
    );
  }

  Widget _passwordConfirmation(bool isPasswordVisible) {
    return PasswordInputComponent(
      padding: Paddings.zero,
      enabled: !widget.isLoading,
      obscureText: isPasswordVisible,
      textInputAction: TextInputAction.done,
      formFields: _passwordConfirmFormFields,
      labelText: Strings.passwordConfirmationInputLabelText,
      onChangedObscureText: widget.controller.togglePasswordVisible,
      onChanged: (value) {
        widget.controller.onFormChanged(
          UserFormType.confirmPassword,
          value ?? '',
        );
      },
      validator: (value) {
        final password = _passwordFormFields.controller?.text;
        return Validators.confirmPassword(password, value);
      },
      onFieldSubmitted: (_) => widget.onSubmitted(),
    );
  }

  Widget _onSubmittedButton() {
    return DefaultButton(
      isValid: true,
      isLoading: widget.isLoading,
      title: Strings.nextProgress,
      onPressed: widget.onSubmitted,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameFormFields.dispose();
    _emailFormFields.dispose();
    _passwordFormFields.dispose();
    _securityCodeFormFields.dispose();
    _passwordConfirmFormFields.dispose();
  }
}
