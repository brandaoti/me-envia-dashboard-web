import 'package:flutter/widgets.dart';

import '../../../core/values/values.dart';

class ProofOfPaymentState {
  final Color primary;
  final String message;
  final bool iconVisible;
  final bool isButtonsEnabled;

  const ProofOfPaymentState({
    required this.primary,
    required this.message,
    required this.iconVisible,
    required this.isButtonsEnabled,
  });

  factory ProofOfPaymentState.disable() {
    return ProofOfPaymentState(
      iconVisible: false,
      isButtonsEnabled: false,
      primary: AppColors.grey400,
      message: Strings.paymentStatusMessage.first,
    );
  }

  factory ProofOfPaymentState.initial({
    String? message,
    bool? iconVisible,
    bool? isButtonsEnabled,
  }) {
    return ProofOfPaymentState(
      iconVisible: iconVisible ?? true,
      primary: AppColors.alertBlueColor,
      isButtonsEnabled: isButtonsEnabled ?? true,
      message: message ?? Strings.paymentStatusMessage[1],
    );
  }

  factory ProofOfPaymentState.sucess() {
    return ProofOfPaymentState(
      iconVisible: true,
      isButtonsEnabled: false,
      primary: AppColors.alertGreenColor,
      message: Strings.paymentStatusMessage[2],
    );
  }

  factory ProofOfPaymentState.error({String? message}) {
    return ProofOfPaymentState(
      iconVisible: true,
      isButtonsEnabled: false,
      primary: AppColors.alertRedColor,
      message: message ?? Strings.paymentStatusMessage.last,
    );
  }
}
