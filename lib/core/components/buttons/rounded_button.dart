import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../values/values.dart';
import '../components.dart';

class RoundedButton extends StatelessWidget {
  final String? title;
  final bool isValid;
  final VoidCallback? onPressed;
  final bool isLoading;

  const RoundedButton({
    Key? key,
    this.title = '',
    this.onPressed,
    this.isValid = true,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Dimens.buttonHeight,
      child: TextButton(
        child: _child(),
        style: getButtonStyle(),
        onPressed: isValid ? onPressed : null,
      ),
    );
  }

  ButtonStyle getButtonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        isValid ? Colors.transparent : AppColors.disabledButtonOffsetColor,
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            width: 2.0,
            color: isValid ? AppColors.primary : AppColors.grey200,
          ),
        ),
      ),
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
      height: 18,
      color: AppColors.primary,
    );
  }

  Widget _text() {
    return AutoSizeText(
      title ?? '',
      style: TextStyles.roundedButton(isValid),
    );
  }
}
