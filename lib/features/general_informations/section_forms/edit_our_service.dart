import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/core.dart';
import '../states/create_learn_more_state.dart';
import 'section_edit_controller.dart';

class EditOurService extends StatefulWidget {
  final VoidCallback onClosed;
  final MariaInformation description;

  const EditOurService({
    Key? key,
    required this.onClosed,
    required this.description,
  }) : super(key: key);

  @override
  _EditMariaInformationState createState() => _EditMariaInformationState();
}

class _EditMariaInformationState extends State<EditOurService> {
  final _formKey = GlobalKey<FormState>();
  final _createInformationFormField = FormFields();

  final _controller = Modular.get<SectionEditController>();

  @override
  void initState() {
    _controller.init(information: widget.description);
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

    _createInformationFormField.controller?.text = widget.description.text;
  }

  void _handleCreateNewDescription() {
    final isValid = _formKey.currentState?.validate() ?? false;

    final description = _createInformationFormField.getMaskValue;

    if (!isValid) return;

    _controller.handleUpdateOurService(description ?? '');
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
          child: const ModalEditingCompleted(),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _title(),
          const VerticalSpacing(
            height: 32,
          ),
          _ourServiceformField(),
          const VerticalSpacing(
            height: 16,
          ),
          _confirmBtn(),
        ],
      ),
    );
  }

  Widget _title() {
    return AutoSizeText(
      Strings.sectionEditTitle(Strings.serviceTitle),
      textAlign: TextAlign.left,
      style: TextStyles.requestedBoxTitle,
    );
  }

  Widget _ourServiceformField() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 240),
      child: TextFormField(
        validator: Validators.required,
        maxLength: Dimens.maxCharactersInput,
        keyboardType: TextInputType.multiline,
        focusNode: _createInformationFormField.focus,
        maxLines: Dimens.maxLinesCharactersMariaTips,
        controller: _createInformationFormField.controller,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          border: Decorations.inputBorderForms,
          labelText: Strings.serviceTitle,
        ),
      ),
    );
  }

  Widget _confirmBtn() {
    return StreamBuilder<CreateLearnMoreState>(
      stream: _controller.createInformationStateStream,
      builder: (context, snapshot) {
        return DefaultButton(
          radius: 8.0,
          isValid: true,
          title: Strings.confirm,
          onPressed: _handleCreateNewDescription,
          isLoading: snapshot.data is CreateLearnMoreLoadingState,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _formKey.currentState?.dispose();
    _createInformationFormField.dispose();

    super.dispose();
  }
}
