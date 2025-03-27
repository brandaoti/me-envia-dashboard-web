import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../values/values.dart';

class ModalEditingCompleted extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color iconColor;
  final Color background;

  const ModalEditingCompleted({
    Key? key,
    this.iconColor = AppColors.alertGreenColor,
    this.background = AppColors.alertGreenColorLight,
    this.title = Strings.modalSectionMariaInformationTitle,
    this.subtitle = Strings.modalSectionMariaInformationMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _builder();
  }

  Widget _builder() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _illustration(),
          const VerticalSpacing(height: 32),
          _text(message: title),
          const VerticalSpacing(height: 32),
          _text(
            message: subtitle,
            style: TextStyles.modalEditingCompletedStyle.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _illustration() {
    const double maxWidth = 144;
    return Container(
      constraints: const BoxConstraints(
        minWidth: maxWidth,
        minHeight: maxWidth,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: background,
      ),
      child: Icon(Icons.check_rounded, color: iconColor, size: 72),
    );
  }

  Widget _text({
    required String message,
    TextStyle? style,
  }) {
    return AutoSizeText(
      message,
      textAlign: TextAlign.center,
      style: style ?? TextStyles.modalEditingCompletedStyle,
    );
  }
}
