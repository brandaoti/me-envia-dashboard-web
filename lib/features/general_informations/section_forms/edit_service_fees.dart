import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/core.dart';
import '../states/create_learn_more_state.dart';
import 'section_edit_controller.dart';

class EditServiceFees extends StatefulWidget {
  final MariaInformation description;
  final VoidCallback onClosed;

  const EditServiceFees({
    Key? key,
    required this.description,
    required this.onClosed,
  }) : super(key: key);

  @override
  _EditServiceFeesState createState() => _EditServiceFeesState();
}

class _EditServiceFeesState extends State<EditServiceFees> {
  final _formKey = GlobalKey<FormState>();
  final _createFeesFormField = FormFields();
  final _createVolumeFormField = FormFields();
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

    _createVolumeFormField.controller?.text = widget.description.text;
    _createFeesFormField.controller?.text = widget.description.subtitle;
  }

  void _handleCreateNewDescription() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    final serviceFees = _createFeesFormField.getMaskValue ?? '';
    final volume = _createVolumeFormField.getMaskValue ?? '';

    _controller.handleUpdateServiceFees(
      feesDescription: serviceFees,
      volumeDescription: volume,
    );
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
        return Visibility(
          replacement: _content(),
          child: const ModalEditingCompleted(),
          visible: snapshot.data is CreateLearnMoreSucessState,
        );
      },
    );
  }

  Widget _content() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(),
            const VerticalSpacing(
              height: 32,
            ),
            _serviceFeesFormField(),
            const VerticalSpacing(
              height: 16,
            ),
            _volumeFormField(),
            const VerticalSpacing(
              height: 16,
            ),
            _confirmBtn(),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return AutoSizeText(
      Strings.sectionEditTitle(Strings.feesTitle),
      textAlign: TextAlign.left,
      style: TextStyles.requestedBoxTitle,
    );
  }

  Widget _serviceFeesFormField() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 240),
      child: TextFormField(
        validator: Validators.required,
        keyboardType: TextInputType.multiline,
        focusNode: _createFeesFormField.focus,
        controller: _createFeesFormField.controller,
        maxLength: Dimens.maxCharactersInput,
        maxLines: Dimens.maxLinesCharactersMariaTips - 2,
        decoration: const InputDecoration(
          alignLabelWithHint: true,
          labelText: Strings.feesTitle,
        ),
        onFieldSubmitted: (_) {
          _createVolumeFormField.focus?.requestFocus();
        },
      ),
    );
  }

  Widget _volumeFormField() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 240),
      child: TextFormField(
        validator: Validators.required,
        keyboardType: TextInputType.multiline,
        focusNode: _createVolumeFormField.focus,
        maxLength: Dimens.maxCharactersInput,
        maxLines: Dimens.maxLinesCharactersMariaTips - 2,
        controller: _createVolumeFormField.controller,
        decoration: const InputDecoration(
          alignLabelWithHint: true,
          labelText: Strings.volumeTitle,
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
    _createFeesFormField.dispose();
    _createVolumeFormField.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }
}
