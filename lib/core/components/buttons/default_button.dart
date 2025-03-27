import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../values/values.dart';
import '../components.dart';

class DefaultButton extends StatelessWidget {
  final String? title;
  final bool isValid;
  final bool isLoading;
  final double radius;
  final double minFontSize;

  final EdgeInsets? padding;
  final VoidCallback? onPressed;

  final double width;
  final double height;
  final double? fontSize;

  const DefaultButton({
    Key? key,
    this.title = '',
    this.padding,
    this.onPressed,
    this.fontSize,
    this.radius = 4,
    this.isValid = false,
    this.minFontSize = 14,
    this.isLoading = false,
    this.width = double.infinity,
    this.height = Dimens.buttonHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        child: _child(),
        style: getButtonStyle(),
        onPressed: isValid ? onPressed : null,
      ),
    );
  }

  ButtonStyle getButtonStyle() {
    return ButtonStyle(
      padding: MaterialStateProperty.all(padding),
      backgroundColor: MaterialStateProperty.all<Color>(
        isValid ? AppColors.primary : AppColors.disabledButtonOffsetColor,
      ),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      )),
    );
  }

  Widget _child() {
    return Visibility(
      visible: isLoading,
      child: _isLoading(),
      replacement: _text(),
    );
  }

  Widget _isLoading() {
    return const Loading(
      height: 68,
      color: AppColors.whiteDefault,
    );
  }

  Widget _text() {
    return AutoSizeText(
      title ?? '',
      minFontSize: minFontSize,
      style: TextStyles.defaultButton(isValid).copyWith(
        fontSize: fontSize,
      ),
    );
  }
}
