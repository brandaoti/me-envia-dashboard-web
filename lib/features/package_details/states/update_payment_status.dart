abstract class UpdatePaymentStatus {}

class UpdatePaymentLoadingStatus implements UpdatePaymentStatus {
  final bool isRecusedSectionInLoading;
  const UpdatePaymentLoadingStatus({
    this.isRecusedSectionInLoading = true,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UpdatePaymentLoadingStatus &&
        other.isRecusedSectionInLoading == isRecusedSectionInLoading;
  }

  @override
  int get hashCode => isRecusedSectionInLoading.hashCode;

  @override
  String toString() =>
      'UpdatePaymentLoadingStatus(isRecusedSectionInLoading: $isRecusedSectionInLoading)';
}

class UpdatePaymentSuccessStatus implements UpdatePaymentStatus {
  const UpdatePaymentSuccessStatus();
}

class UpdatePaymentErrorStatus implements UpdatePaymentStatus {
  final String? message;

  const UpdatePaymentErrorStatus({
    this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UpdatePaymentErrorStatus && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
