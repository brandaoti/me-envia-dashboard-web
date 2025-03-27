import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../features.dart';

import '../../package_details/states/tracking_code_state.dart';

class ModalAddTrackingCode {
  final BuildContext context;
  final String? trackingCode;
  final String packageId;
  final VoidCallback? onClosed;

  final _formKey = GlobalKey<FormState>();

  final _controller = Modular.get<TrackingCodeController>();

  ModalAddTrackingCode({
    required this.context,
    required this.trackingCode,
    required this.packageId,
    this.onClosed,
  });

  void show() {
    _controller.init();

    showDialog(
      context: context,
      builder: _builder,
    );
  }

  void _dispose() {
    _controller.dispose();
    onClosed?.call();
  }

  Widget _builder(
    BuildContext context,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        child: Center(child: _body()),
        padding: Paddings.modalCreateNewFaq,
        constraints: Sizes.modalMaxWidth(330),
      ),
    );
  }

  Widget _body() {
    return StreamBuilder<TrackingCodeState>(
      stream: _controller.trackingCodeStateStream,
      builder: (context, snapshot) {
        final states = snapshot.data;
        return Visibility(
          replacement: _content(),
          child: const ModalEditingCompleted(),
          visible: states is TrackingCodeSuccessState,
        );
      },
    );
  }

  Widget _content() {
    return Form(
      key: _formKey,
      child: SectionTrackingCode(
        sectionTitle: Strings.addTrackingCode,
        packageId: packageId,
        onValidate: () => _formKey.currentState?.validate() ?? false,
        trackingCode: trackingCode,
        packageEditSection: PackageEditSection.trackingCode,
        onClosed: _dispose,
      ),
    );
  }
}
