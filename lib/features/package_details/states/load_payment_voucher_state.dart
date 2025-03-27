abstract class LoadPaymentVoucherState {}

class LoadPaymentVoucherLoadingState implements LoadPaymentVoucherState {
  final double progress;
  const LoadPaymentVoucherLoadingState({
    this.progress = 0,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoadPaymentVoucherLoadingState &&
        other.progress == progress;
  }

  @override
  int get hashCode => progress.hashCode;

  @override
  String toString() => 'LoadPaymentVoucherLoadingState(progress: $progress)';
}

class LoadPaymentVoucherSucessState implements LoadPaymentVoucherState {
  const LoadPaymentVoucherSucessState();
}

class LoadPaymentVoucherErrorState implements LoadPaymentVoucherState {
  final String? message;
  const LoadPaymentVoucherErrorState({
    this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoadPaymentVoucherErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'LoadPaymentVoucherErrorState(message: $message)';
}
