import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../core.dart';

class ErrorState extends StatelessWidget {
  final String message;
  final double? height;
  final TextAlign textAlign;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;

  final bool isButtonVisibility;
  final String textButton;

  const ErrorState({
    Key? key,
    this.padding,
    this.onPressed,
    this.height = 260,
    this.textAlign = TextAlign.left,
    this.isButtonVisibility = false,
    this.message = Strings.noStockBox,
    this.textButton = Strings.tryAgain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      padding: padding,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeText(
            message,
            style: TextStyles.orderBoxProduct.copyWith(
              height: 1.2,
              fontSize: 24,
            ),
            textAlign: textAlign,
          ),
          Visibility(
            visible: isButtonVisibility,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: DefaultButton(
                isValid: true,
                title: textButton,
                onPressed: onPressed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
