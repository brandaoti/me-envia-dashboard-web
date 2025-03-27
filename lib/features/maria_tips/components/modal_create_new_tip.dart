import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../maria_tips.dart';

class ModalCreateNewTip {
  final MariaTips? tips;
  final BuildContext context;
  final VoidCallback onClosed;

  ModalCreateNewTip({
    this.tips,
    required this.context,
    required this.onClosed,
  });

  void show() {
    showDialog(
      context: context,
      builder: _builder,
    );
  }

  Widget _builder(
    BuildContext context,
  ) {
    return _content();
  }

  Widget _content() {
    return Dialog(
      shape: Decorations.allModalBorderRadius(),
      child: Container(
        constraints: Sizes.modalMaxWidth(),
        padding: Paddings.mariaTipsCardPadding,
        child: CreateTipsScreen(tips: tips, onClosed: onClosed),
      ),
    );
  }
}
