import 'package:flutter_modular/flutter_modular.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../states/create_tips_state.dart';
import 'create_new_tips_controller.dart';

class CreateTipsScreen extends StatefulWidget {
  final MariaTips? tips;
  final VoidCallback onClosed;

  const CreateTipsScreen({
    Key? key,
    required this.tips,
    required this.onClosed,
  }) : super(key: key);

  @override
  _CreateTipsScreenState createState() => _CreateTipsScreenState();
}

class _CreateTipsScreenState extends State<CreateTipsScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleItemFormField = FormFields();
  final _linkItemFormField = FormFields();
  final _descriptionItemFormField = FormFields();

  final _controller = Modular.get<CreateNewTipsController>();

  bool get hasEditTips => widget.tips != null;

  @override
  void initState() {
    _controller.init(tips: widget.tips);
    _updateFormFields();
    _startListener();
    super.initState();
  }

  void _startListener() {
    _controller.createTipsStateStream.listen((states) async {
      if (states is CreateTipsSucessState) {
        await Future.delayed(Durations.transitionToNavigate);
        widget.onClosed();
      }
    });
  }

  void _updateFormFields() {
    if (widget.tips == null) return;

    final MariaTips tips = widget.tips!;

    _titleItemFormField.controller?.text = tips.title ?? '';
    _linkItemFormField.controller?.text = tips.link ?? '';
    _descriptionItemFormField.controller?.text = tips.description ?? '';
  }

  void _handleCreateNewTips() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (isValid) {
      _controller.handleCreateNewTips();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: _body(),
    );
  }

  Widget _title() {
    return Align(
      alignment: Alignment.center,
      child: AutoSizeText(
        widget.tips == null ? Strings.createNewTip : Strings.editCurrentTip,
        textAlign: TextAlign.center,
        style: TextStyles.requestedBoxTitle,
      ),
    );
  }

  Widget _body() {
    return StreamBuilder<CreateTipsState>(
      stream: _controller.createTipsStateStream,
      builder: (context, snapshot) => Visibility(
        replacement: _content(),
        child: _done(snapshot.data),
        visible: snapshot.data is CreateTipsSucessState,
      ),
    );
  }

  Widget _content() {
    return SingleChildScrollView(
      padding: Paddings.horizontal,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VerticalSpacing(
              height: 24,
            ),
            _title(),
            const VerticalSpacing(
              height: 48,
            ),
            _openFile(),
            const VerticalSpacing(
              height: 32,
            ),
            _titleFormField(),
            const VerticalSpacing(
              height: 32,
            ),
            _linkFormField(),
            const VerticalSpacing(
              height: 32,
            ),
            _descrptionFormField(),
            const VerticalSpacing(
              height: 32,
            ),
            _deleteButton(),
            _finishButton(),
            const VerticalSpacing(
              height: 48,
            ),
          ],
        ),
      ),
    );
  }

  Widget _openFile() {
    return OpenPhotoFile(
      text: Strings.photoFileUploadTitleTips,
      onPressed: _controller.handleOpenFile,
      stream: _controller.openFileStateStream,
    );
  }

  Widget _titleFormField() {
    return TextFormField(
      validator: Validators.tipTitle,
      keyboardType: TextInputType.text,
      focusNode: _titleItemFormField.focus,
      controller: _titleItemFormField.controller,
      decoration: InputDecoration(
        filled: true,
        border: Decorations.inputBorderForms,
        labelText: Strings.titleInputLabelText,
      ),
      onChanged: (value) {
        _controller.onFormChane(CreateFormType.title, value);
      },
      onFieldSubmitted: (_) {
        _linkItemFormField.focus?.requestFocus();
      },
    );
  }

  Widget _linkFormField() {
    return TextFormField(
      validator: (value) {
        if ((value ?? '').isNotEmpty) {
          return Validators.link(value);
        }

        return null;
      },
      keyboardType: TextInputType.url,
      focusNode: _linkItemFormField.focus,
      controller: _linkItemFormField.controller,
      decoration: InputDecoration(
        filled: true,
        border: Decorations.inputBorderForms,
        labelText: Strings.linkInputLabelText,
      ),
      onChanged: (value) {
        _controller.onFormChane(CreateFormType.link, value);
      },
      onFieldSubmitted: (_) {
        _descriptionItemFormField.focus?.requestFocus();
      },
    );
  }

  Widget _descrptionFormField() {
    return StreamBuilder<CreateTipsState>(
      stream: _controller.createTipsStateStream,
      builder: (context, snapshot) {
        String? errorText;
        final states = snapshot.data;

        if (states is CreateTipsErrorState) {
          errorText = states.message;
        }

        return ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 160),
          child: TextFormField(
            validator: Validators.required,
            keyboardType: TextInputType.multiline,
            maxLength: Dimens.maxCharactersMariaTips,
            focusNode: _descriptionItemFormField.focus,
            maxLines: Dimens.maxLinesCharactersMariaTips,
            controller: _descriptionItemFormField.controller,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              errorText: errorText,
              border: Decorations.inputBorderForms,
              labelText: Strings.descriptionInputLabelText,
            ),
            onChanged: (value) {
              _controller.onFormChane(CreateFormType.description, value);
            },
          ),
        );
      },
    );
  }

  Widget _deleteButton() {
    return StreamBuilder<CreateTipsState>(
      stream: _controller.createTipsStateStream,
      builder: (context, snapshot) => Visibility(
        visible: hasEditTips,
        child: Padding(
          child: RoundedButton(
            title: Strings.removeTips,
            onPressed: _controller.handleRemoveTips,
            isValid: true && snapshot.data is! CreateTipsLoadingState,
          ),
          padding: const EdgeInsets.only(bottom: 16),
        ),
      ),
    );
  }

  Widget _finishButton() {
    return StreamBuilder<CreateTipsState>(
      stream: _controller.createTipsStateStream,
      builder: (context, snapshot) => DefaultButton(
        isValid: true,
        title: Strings.confirm,
        onPressed: _handleCreateNewTips,
        isLoading: snapshot.data is CreateTipsLoadingState,
      ),
    );
  }

  Widget _done(CreateTipsState? states) {
    if (states is CreateTipsSucessState) {
      final listOfDoneTilte = Strings.mariaTipsState[states.section];

      return Padding(
        child: ModalEditingCompleted(
          title: listOfDoneTilte?.first ?? '',
          subtitle: listOfDoneTilte?.last ?? '',
        ),
        padding: Paddings.horizontal,
      );
    }

    return Container();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _titleItemFormField.dispose();
    _linkItemFormField.dispose();
    _descriptionItemFormField.dispose();
    _controller.dispose();
    super.dispose();
  }
}
