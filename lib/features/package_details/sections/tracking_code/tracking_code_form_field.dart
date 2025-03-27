import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/components/components.dart';
import '../../../../core/helpers/helpers.dart';
import '../../../../core/values/values.dart';
import '../../components/section_title_texts.dart';
import '../../components/suffix_icon_check.dart';
import '../../package_screen_detail.dart';
import '../../states/package_edit_section.dart';
import '../../states/tracking_code_state.dart';
import 'tracking_code_controller.dart';

class SectionTrackingCode extends StatefulWidget {
  final String packageId;
  final String sectionTitle;
  final String? trackingCode;
  final bool useDefaultLayout;
  final VoidCallback? onClosed;

  final OnValidateField onValidate;
  final PackageEditSection? packageEditSection;

  const SectionTrackingCode({
    Key? key,
    this.onClosed,
    this.packageEditSection,
    required this.packageId,
    required this.onValidate,
    required this.trackingCode,
    this.useDefaultLayout = true,
    this.sectionTitle = Strings.trackingCodeTitle,
  }) : super(key: key);

  @override
  _SectionTrackingCodeState createState() => _SectionTrackingCodeState();
}

class _SectionTrackingCodeState extends State<SectionTrackingCode> {
  final _trackingCodeFormField = FormFields();
  final _controller = Modular.get<TrackingCodeController>();

  bool _isEnableButton = false;

  @override
  void initState() {
    _controller.init(trackingCode: widget.trackingCode);
    _updateFormField();
    _startListerner();
    super.initState();
  }

  void _startListerner() {
    _trackingCodeFormField.controller?.addListener(() {
      final value = _trackingCodeFormField.controller?.text;

      setState(() {
        _isEnableButton = value != null && value.isNotEmpty;
      });
    });

    _controller.trackingCodeStateStream.listen((states) {
      if (states is TrackingCodeSuccessState) {
        widget.onClosed?.call();
      }
    });
  }

  void _updateFormField() {
    _trackingCodeFormField.controller?.text = widget.trackingCode ?? '';
  }

  Future<void> _handleChangeTrackingCode() async {
    if (widget.onValidate()) {
      await _controller.updateTrackingCodeValue(packageId: widget.packageId);
    }
  }

  bool get _isTrackingCodeSection =>
      widget.packageEditSection == PackageEditSection.trackingCode;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.useDefaultLayout,
      child: _bodyWithDefaultLayout(),
      replacement: _bodyWithOtherLayout(),
    );
  }

  Widget _bodyWithDefaultLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(),
        const VerticalSpacing(
          height: 16.0,
        ),
        _trackingCode(),
        const VerticalSpacing(
          height: 16.0,
        ),
        _saveBtn(),
      ],
    );
  }

  Widget _bodyWithOtherLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(),
        const VerticalSpacing(
          height: 16.0,
        ),
        _bodyWithOtherLayoutContent(),
      ],
    );
  }

  Widget _bodyWithOtherLayoutContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = (constraints.maxWidth / 2) - Dimens.vertical;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ConstrainedBox(
              child: _trackingCode(),
              constraints: BoxConstraints(maxWidth: maxWidth),
            ),
            ConstrainedBox(
              child: _saveBtn(),
              constraints: BoxConstraints(maxWidth: maxWidth),
            ),
          ],
        );
      },
    );
  }

  Widget _title() {
    return SectionTitle(
      fontSize: 24,
      color: AppColors.grey500,
      title: widget.sectionTitle,
    );
  }

  Widget _trackingCode() {
    return StreamBuilder<TrackingCodeState>(
      stream: _controller.trackingCodeStateStream,
      builder: (context, snapshot) {
        String? errorText;
        InputBorder? border;
        bool isIconVisiblity = false;

        final state = snapshot.data;

        if (state is TrackingCodeErrorState) {
          errorText = state.message;
        }

        if (state is TrackingCodeSuccessState) {
          isIconVisiblity = true;
          border = Decorations.outlineInputBorder;
        }

        return _trackingCodeForm(
          border: border,
          errorText: errorText,
          isIconVisiblity: isIconVisiblity,
          isEnabled: state is! TrackingCodeSuccessState,
          isReadOnly: (state is TrackingCodeSuccessState),
        );
      },
    );
  }

  Widget _trackingCodeForm({
    String? errorText,
    InputBorder? border,
    bool isIconVisiblity = false,
    bool isEnabled = true,
    bool isReadOnly = false,
  }) {
    return TextFormField(
      readOnly: isReadOnly,
      textAlign: TextAlign.start,
      keyboardType: TextInputType.text,
      textDirection: TextDirection.ltr,
      decoration: InputDecoration(
        enabled: isEnabled && _isTrackingCodeSection,
        errorMaxLines: 2,
        errorText: errorText,
        labelText: Strings.trackingCodeLabel,
        border: Decorations.outlineInputBorder,
        contentPadding: Paddings.contentPadding,
        enabledBorder: border,
        focusedBorder: border,
        disabledBorder: border,
        suffixIcon: Visibility(
          visible: isIconVisiblity,
          child: const SuffixIconCheck(),
        ),
        fillColor: isIconVisiblity
            ? AppColors.alertGreenColorLight.withOpacity(.3)
            : null,
      ),
      focusNode: _trackingCodeFormField.focus,
      controller: _trackingCodeFormField.controller,
      validator: (value) {
        return _isTrackingCodeSection ? Validators.required(value) : null;
      },
      onChanged: (_) {
        _controller.onChangeTrackingCode(
          _trackingCodeFormField.controller?.text ?? '',
        );
      },
    );
  }

  Widget _saveBtn() {
    return StreamBuilder<TrackingCodeState>(
      stream: _controller.trackingCodeStateStream,
      builder: (context, snapshot) {
        final states = snapshot.data;

        final bool isValid = states is! TrackingCodeSuccessState;

        return DefaultButton(
          radius: 8,
          title: Strings.saveChangesBtn,
          onPressed: _handleChangeTrackingCode,
          isLoading: states is TrackingCodeLoadingState,
          isValid: isValid && _isEnableButton && _isTrackingCodeSection,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _trackingCodeFormField.dispose();
    super.dispose();
  }
}
