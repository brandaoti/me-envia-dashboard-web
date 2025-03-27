import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../create_items.dart';

class ModalAddNewItem {
  final BuildContext context;
  final Customers customers;

  const ModalAddNewItem({
    required this.context,
    required this.customers,
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
        child: AddNewItemScreen(
          customers: customers,
        ),
      ),
    );
  }
}
