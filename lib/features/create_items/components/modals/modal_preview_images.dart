import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/core.dart';

class ModalPreviewImages {
  final Box box;
  final int index;
  final BuildContext context;

  final Uuid _uuid;

  const ModalPreviewImages({
    required this.box,
    required this.index,
    required this.context,
  }) : _uuid = const Uuid();

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
        constraints: Sizes.modalPreviewImageMaxWidgth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(),
            const VerticalSpacing(
              height: 30,
            ),
            _imageItem(),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return AutoSizeText(
      !box.nameIsEmpty ? box.name : Strings.boxItemName(index),
      style: TextStyles.noConnectionTitle.copyWith(
        fontSize: 24,
        color: AppColors.secondary,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _imageItem() {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 260,
        maxWidth: double.infinity,
      ),
      child: IgnorePointer(
        child: PlatformImage.element(
          box.media!,
          radius: 10,
          viewTypeId: _uuid.v4(),
        ),
      ),
    );
  }
}
