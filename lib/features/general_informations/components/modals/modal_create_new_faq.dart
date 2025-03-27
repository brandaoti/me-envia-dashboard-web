import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../section_forms/edit_faq.dart';

class ModalCreateNewFaq {
  final Faq? faq;
  final BuildContext context;
  final VoidCallback onClosed;

  const ModalCreateNewFaq({
    required this.faq,
    required this.context,
    required this.onClosed,
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
        child: EditFaq(faq: faq, onClosed: onClosed),
      ),
    );
  }
}
