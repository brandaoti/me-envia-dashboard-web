import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../section_forms/edit_who_is_maria.dart';

class ModalEditWhoIsMaria {
  final BuildContext context;
  final VoidCallback onClosed;
  final MariaInformation description;

  const ModalEditWhoIsMaria({
    required this.context,
    required this.onClosed,
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
        child:
            EditMariaInformation(description: description, onClosed: onClosed),
      ),
    );
  }
}
