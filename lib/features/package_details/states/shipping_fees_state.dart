abstract class ShippingFeeState {}

class ShippingFeeInitialState implements ShippingFeeState {
  const ShippingFeeInitialState();
}

class ShippingFeeLoadingState implements ShippingFeeState {
  const ShippingFeeLoadingState();
}

class ShippingFeeSuccessState implements ShippingFeeState {
  final double shippingFee;

  const ShippingFeeSuccessState({
    required this.shippingFee,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShippingFeeSuccessState && other.shippingFee == shippingFee;
  }

  @override
  int get hashCode => shippingFee.hashCode;

  @override
  String toString() => 'ShippingFeeSuccessState(shippingFee: $shippingFee)';
}

class ShippingFeeErrorState implements ShippingFeeState {
  final String? message;

  const ShippingFeeErrorState({
    this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShippingFeeErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
