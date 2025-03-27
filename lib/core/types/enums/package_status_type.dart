enum PackageStatusType {
  awaitingFee,
  awaitingPayment,
  paymentAccept,
  paymentRefused,
  paymentSubjectToConfirmation,
}

extension PackageStatusTypeExtension on PackageStatusType {
  String get value {
    switch (this) {
      case PackageStatusType.awaitingFee:
        return 'Aguardando Taxa';
      case PackageStatusType.awaitingPayment:
        return 'Aguardando o pagamento!';
      case PackageStatusType.paymentSubjectToConfirmation:
        return 'Pagamento sujeito a confirmação!';
      case PackageStatusType.paymentAccept:
        return 'Pagamento Aprovado!';
      case PackageStatusType.paymentRefused:
        return 'Pagamento Recusado!';
      default:
        return 'Aguardando Taxa';
    }
  }
}

extension JsonPackageStatusTypeExtension on String {
  PackageStatusType? get fromStatusType {
    if (this == PackageStatusType.awaitingFee.value) {
      return PackageStatusType.awaitingFee;
    } else if (this == PackageStatusType.awaitingPayment.value) {
      return PackageStatusType.awaitingPayment;
    } else if (this == PackageStatusType.paymentAccept.value) {
      return PackageStatusType.paymentAccept;
    } else if (this == PackageStatusType.paymentRefused.value) {
      return PackageStatusType.paymentRefused;
    } else if (this == PackageStatusType.paymentSubjectToConfirmation.value) {
      return PackageStatusType.paymentSubjectToConfirmation;
    } else {
      return null;
    }
  }
}
