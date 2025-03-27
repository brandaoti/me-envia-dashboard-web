import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../section_forms/edit_service_fees.dart';

class ModalEditServiceFees {
  final VoidCallback onClosed;
  final BuildContext context;
  final MariaInformation description;

  const ModalEditServiceFees({
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
        constraints: Sizes.modalMaxWidth(),
        padding: Paddings.allDefaultModal,
        child: EditServiceFees(
          onClosed: onClosed,
          description: description,
        ),
      ),
    );
  }
}
