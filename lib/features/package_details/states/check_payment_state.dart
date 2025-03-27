abstract class CheckPaymentState {}

class CheckPaymentAllDisableState implements CheckPaymentState {
  const CheckPaymentAllDisableState();
}

class CheckPaymentInitialState implements CheckPaymentState {
  final bool hasPaymentVoucher;

  const CheckPaymentInitialState({
    this.hasPaymentVoucher = false,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CheckPaymentInitialState &&
        other.hasPaymentVoucher == hasPaymentVoucher;
  }

  @override
  int get hashCode => hasPaymentVoucher.hashCode;

  @override
  String toString() =>
      'CheckPaymentInitialState(hasPaymentVoucher: $hasPaymentVoucher)';
}

class CheckPaymentLoadingState implements CheckPaymentState {
  const CheckPaymentLoadingState();
}

class CheckPaymentSucessState implements CheckPaymentState {
  const CheckPaymentSucessState();
}

class CheckPaymentErrorState implements CheckPaymentState {
  final String? message;

  const CheckPaymentErrorState({
    this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CheckPaymentErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'CheckPaymentErrorState(message: $message)';
}
