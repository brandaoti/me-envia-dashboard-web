import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../contact.dart';

class TalkToMeForm extends StatefulWidget {
  final ContactController controller;
  const TalkToMeForm({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _TalkToMeFormState createState() => _TalkToMeFormState();
}

class _TalkToMeFormState extends State<TalkToMeForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameFormFields = FormFields();
  final _emailFormFields = FormFields();
  final _descriptionFormFields = FormFields();
  final _phoneFormFields = FormFields.mask(mask: '(00) 00000-0000');

  @override
  void dispose() {
    _nameFormFields.dispose();
    _phoneFormFields.dispose();
    _emailFormFields.dispose();
    _descriptionFormFields.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  void _handleFormSubmit() async {
    final bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    await widget.controller.handleSendFeedback(
      name: _nameFormFields.getText ?? '',
      email: _emailFormFields.getText ?? '',
      phone: _phoneFormFields.getText ?? '',
      message: _descriptionFormFields.getText ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.controller.isSendFeedback,
      builder: (context, isSendFeedback, child) => _body(isSendFeedback),
    );
  }

  Widget _body(bool isSendFeedback) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _name(),
          _email(),
          _phone(),
          _description(),
          const VerticalSpacing(
            height: 24,
          ),
          _submitButton(isSendFeedback)
        ],
      ),
    );
  }

  Widget _name() {
    return NameInputComponent(
      enabled: true,
      formFields: _nameFormFields,
      validator: Validators.required,
      padding: Paddings.contactFormFiels,
      contentPadding: Paddings.contactFormFiels2,
      onChanged: (String? value) {},
      onFieldSubmitted: (_) {
        _emailFormFields.focus?.requestFocus();
      },
    );
  }

  Widget _email() {
    return EmailInputComponent(
      enabled: true,
      validator: Validators.email,
      formFields: _emailFormFields,
      padding: Paddings.contactFormFiels,
      contentPadding: Paddings.contactFormFiels2,
      onChanged: (String? value) {},
      onFieldSubmitted: (_) {
        _phoneFormFields.focus?.requestFocus();
      },
    );
  }

  Widget _phone() {
    return NameInputComponent(
      enabled: true,
      formFields: _phoneFormFields,
      validator: Validators.required,
      padding: Paddings.contactFormFiels,
      contentPadding: Paddings.contactFormFiels2,
      labelText: Strings.phoneInputLabelText.replaceAll(':', ''),
      onChanged: (String? value) {},
      onFieldSubmitted: (_) {
        _descriptionFormFields.focus?.requestFocus();
      },
    );
  }

  Widget _description() {
    return TextFormField(
      validator: Validators.required,
      keyboardType: TextInputType.text,
      maxLength: Dimens.maxCharactersInput,
      focusNode: _descriptionFormFields.focus,
      controller: _descriptionFormFields.controller,
      maxLines: Dimens.maxLinesCharactersMariaTips - 2,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        border: Decorations.inputBorderForms,
        labelText: Strings.descriptionInputLabelText,
      ),
    );
  }

  Widget _submitButton(bool isLoading) {
    return DefaultButton(
      radius: 8.0,
      isValid: true,
      title: Strings.send,
      isLoading: isLoading,
      onPressed: _handleFormSubmit,
    );
  }
}
