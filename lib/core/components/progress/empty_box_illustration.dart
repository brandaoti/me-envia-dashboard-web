import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core.dart';

class EmptyBoxIllustration extends StatelessWidget {
  final String message;
  final bool fillEveryLineOfText;
  final Widget? additionalWidget;
  final BoxConstraints constraints;
  final double allIllustrationSize;

  const EmptyBoxIllustration({
    Key? key,
    this.additionalWidget,
    this.fillEveryLineOfText = false,
    this.message = Strings.noBoxRequested,
    this.allIllustrationSize = Dimens.navBarMaxWith,
    this.constraints = const BoxConstraints(
      maxHeight: 380,
      minWidth: double.infinity,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _content(),
      constraints: constraints,
      decoration: Decorations.cardOrderItem(false, borderRadius: 10.0),
    );
  }

  Widget _content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _illustration(),
        const VerticalSpacing(height: 26.0),
        _messege(),
        additionalWidget ?? const SizedBox.shrink()
      ],
    );
  }

  Widget _illustration() {
    return SvgPicture.asset(
      Svgs.logoNoItemRegistered,
      width: allIllustrationSize,
      height: allIllustrationSize,
    );
  }

  Widget _messege() {
    final child = AutoSizeText(
      message,
      textAlign: TextAlign.center,
      style: TextStyles.sectionHeaderTitleStyle.copyWith(
        height: 1.4,
        fontSize: 18,
        color: AppColors.grey500,
        fontWeight: FontWeight.w600,
      ),
    );

    return Visibility(
      replacement: child,
      visible: !fillEveryLineOfText,
      child: ConstrainedBox(
        child: child,
        constraints: Sizes.boxIllustrationMessage,
      ),
    );
  }
}
