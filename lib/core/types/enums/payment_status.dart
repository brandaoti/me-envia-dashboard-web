enum PaymentStatus {
  success,
  notPaid,
}

extension PaymentStatusExtension on PaymentStatus {
  String get value {
    switch (this) {
      case PaymentStatus.success:
        return 'PAYMENT_SUCCESS';
      case PaymentStatus.notPaid:
        return 'PAYMENT_NOT_PAID';
      default:
        return 'SUCCESS';
    }
  }
}

extension JsonPaymentStatusExtension on String? {
  PaymentStatus? get fromPaymentType {
    if (this == PaymentStatus.success.value) {
      return PaymentStatus.success;
    } else if (this == PaymentStatus.notPaid.value) {
      return PaymentStatus.notPaid;
    } else {
      return null;
    }
  }
}
