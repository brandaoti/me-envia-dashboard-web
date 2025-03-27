import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../../core.dart';

class ErrorText extends StatelessWidget {
  final String? icon;
  final double? height;
  final String? message;
  final Color? colorText;
  final double imageSize;
  final double? fontSize;
  final double messageWidth;

  final bool isConfirmError;
  final VoidCallback? onConfirm;

  const ErrorText({
    Key? key,
    this.onConfirm,
    this.height = 260,
    this.message = '',
    this.fontSize = 18,
    this.imageSize = 230,
    this.icon = Svgs.logoNoItemRegistered,
    this.isConfirmError = false,
    this.colorText = AppColors.grey500,
    this.messageWidth = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _body(),
      height: height,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _boxIllutrations(),
        const VerticalSpacing(height: 12),
        _message(),
        Visibility(
          visible: isConfirmError,
          child: _confirmButton(),
        ),
      ],
    );
  }

  Widget _boxIllutrations() {
    if ((icon ?? '').isEmpty) {
      return Container();
    }

    return SvgPicture.asset(
      icon!,
      width: imageSize,
      height: imageSize,
    );
  }

  Widget _message() {
    return SizedBox(
      width: messageWidth,
      child: AutoSizeText(
        message,
        textAlign: TextAlign.center,
        style: TextStyles.homeHeaderSubtitle.copyWith(
          color: colorText,
          fontSize: fontSize,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _confirmButton() {
    return Padding(
      padding: Paddings.allDefault,
      child: DefaultButton(
        isValid: true,
        onPressed: onConfirm,
        title: Strings.tryAgain,
      ),
    );
  }
}
