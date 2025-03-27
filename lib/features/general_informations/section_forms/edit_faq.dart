import 'package:flutter_modular/flutter_modular.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

import '../states/create_learn_more_state.dart';
import 'section_edit_controller.dart';

class EditFaq extends StatefulWidget {
  final Faq? faq;
  final VoidCallback onClosed;

  const EditFaq({
    Key? key,
    this.faq,
    required this.onClosed,
  }) : super(key: key);

  @override
  _EditFaqState createState() => _EditFaqState();
}

class _EditFaqState extends State<EditFaq> {
  final _formKey = GlobalKey<FormState>();
  final _titleFormFields = FormFields();
  final _descriptionFormFields = FormFields();

  final _controller = Modular.get<SectionEditController>();

  @override
  void initState() {
    _startListerner();
    super.initState();
  }

  void _startListerner() {
    _controller.createInformationStateStream.listen((states) async {
      if (states is CreateLearnMoreSucessState) {
        await Future.delayed(Durations.transitionToNavigate);
        widget.onClosed();
      }
    });

    _updateFormField();
  }

  void _updateFormField() {
    if (widget.faq == null) return;

    _titleFormFields.controller?.text = widget.faq?.question ?? '';
    _descriptionFormFields.controller?.text = widget.faq?.answer ?? '';
  }

  void _handleCreateFaq() {
    final bool isValid = _formKey.currentState?.validate() ?? false;

    if (isValid) {
      _controller.hangleCreateNewFaq(
        faqId: widget.faq?.id,
        question: _titleFormFields.getMaskValue ?? '',
        answer: _descriptionFormFields.getMaskValue ?? '',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _body(),
    );
  }

  Widget _body() {
    return StreamBuilder<CreateLearnMoreState>(
      stream: _controller.createInformationStateStream,
      builder: (context, snapshot) {
        final states = snapshot.data;

        return Visibility(
          replacement: _content(),
          child: const ModalEditingCompleted(
            title: Strings.modalSectionFaqTitle,
            subtitle: Strings.modalSectionFaqMessage,
          ),
          visible: states is CreateLearnMoreSucessState,
        );
      },
    );
  }

  Widget _content() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(),
          const VerticalSpacing(
            height: 36,
          ),
          _titleFormField(),
          const VerticalSpacing(
            height: 16,
          ),
          _descriptionformField(),
          const VerticalSpacing(
            height: 20,
          ),
          _finishBtn(),
        ],
      ),
    );
  }

  Widget _title() {
    return AutoSizeText(
      Strings.sectionCreateFaqTitle,
      textAlign: TextAlign.left,
      style: TextStyles.userNameStyle,
    );
  }

  Widget _titleFormField() {
    return TextFormField(
      validator: Validators.required,
      keyboardType: TextInputType.text,
      focusNode: _titleFormFields.focus,
      controller: _titleFormFields.controller,
      decoration: InputDecoration(
        border: Decorations.inputBorderForms,
        labelText: Strings.titleInputLabelText,
      ),
    );
  }

  Widget _descriptionformField() {
    return StreamBuilder<CreateLearnMoreState>(
      stream: _controller.createInformationStateStream,
      builder: (context, snapshot) {
        String? errorText;
        final states = snapshot.data;

        if (states is CreateLearnMoreErrorState) {
          errorText = states.message;
        }

        return Container(
          constraints: const BoxConstraints(maxHeight: 180),
          child: TextFormField(
            validator: Validators.required,
            keyboardType: TextInputType.multiline,
            maxLength: Dimens.maxCharactersInput,
            focusNode: _descriptionFormFields.focus,
            maxLines: Dimens.maxLinesCharactersMariaTips,
            controller: _descriptionFormFields.controller,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              errorText: errorText,
              border: Decorations.inputBorderForms,
              labelText: Strings.descriptionInputLabelText,
            ),
          ),
        );
      },
    );
  }

  Widget _finishBtn() {
    return StreamBuilder<CreateLearnMoreState>(
      stream: _controller.createInformationStateStream,
      builder: (context, snapshot) {
        final states = snapshot.data;

        return DefaultButton(
          radius: 8.0,
          isValid: true,
          title: Strings.confirm,
          onPressed: _handleCreateFaq,
          isLoading: states is CreateLearnMoreLoadingState,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _titleFormFields.dispose();
    _formKey.currentState?.dispose();
    _descriptionFormFields.dispose();
    super.dispose();
  }
}
