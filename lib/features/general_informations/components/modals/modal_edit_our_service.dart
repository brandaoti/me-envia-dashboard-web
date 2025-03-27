import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../section_forms/edit_our_service.dart';

class ModalEditOurService {
  final VoidCallback onClosed;
  final BuildContext context;
  final MariaInformation description;

  const ModalEditOurService({
    required this.onClosed,
    required this.context,
    required this.description,
  });

  void show() {
    showDialog(
      context: context,
      builder: _builder,
    );
  }

  Widget _builder(BuildContext context) {
    return Dialog(
      shape: Decorations.allModalBorderRadius(),
      child: Container(
        padding: Paddings.allDefaultModal,
        constraints: Sizes.modalMaxWidth(),
        child: EditOurService(
          onClosed: onClosed,
          description: description,
        ),
      ),
    );
  }
}
