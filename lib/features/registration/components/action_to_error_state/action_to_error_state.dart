import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/components/components.dart';
import '../../../../core/values/values.dart';

class ActionToErrorState {
  final String? message;
  final String? subtitle;
  final BuildContext context;

  const ActionToErrorState({
    this.message,
    required this.context,
    this.subtitle = Strings.errorRegistrationFailure,
  });

  void show() {
    showModalBottomSheet(
      context: context,
      builder: _builder,
      isDismissible: false,
      shape: Decorations.dialogs,
      barrierColor: AppColors.black.withOpacity(0.2),
    );
  }

  Widget _builder(BuildContext context) {
    return SafeArea(
      child: Container(
        child: _body(),
        width: double.infinity,
        padding: Paddings.horizontal,
      ),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _warningIcon(),
        _message(),
        _confirmButon(),
      ],
    );
  }

  Widget _warningIcon() {
    return Padding(
      padding: const EdgeInsets.only(top: 38, bottom: 18),
      child: SvgPicture.asset(
        Svgs.warning,
        height: 140,
        width: 140,
      ),
    );
  }

  Widget _message() {
    return Column(
      children: [
        AutoSizeText(
          message,
          textAlign: TextAlign.center,
          style: TextStyles.resgitrationAccepTermOfUse.copyWith(
            fontSize: 22,
            color: AppColors.secondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const VerticalSpacing(
          height: 16,
        ),
        AutoSizeText(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyles.resgitrationAccepTermOfUse.copyWith(
            height: 1.6,
            fontSize: 18,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _confirmButon() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: DefaultButton(
        isValid: true,
        onPressed: _close,
        title: Strings.ok,
      ),
    );
  }

  void _close() {
    Navigator.of(context).pop();
  }
}
