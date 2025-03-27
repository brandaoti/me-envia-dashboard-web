import '../../types/enums/payment_status.dart';

class UpdatePackage {
  final String? trackingCode;
  final PaymentStatus? paymentStatus;
  final int? shippingFee;

  const UpdatePackage({
    this.trackingCode,
    this.paymentStatus,
    this.shippingFee,
  });

  factory UpdatePackage.fromJson(Map json) {
    return UpdatePackage(
      shippingFee: json['shippingFee'],
      trackingCode: json['trackingCode'],
      paymentStatus: (json['paymentStatus'] as String).fromPaymentType,
    );
  }

  Map toMap() {
    final Map data = {};

    if (trackingCode != null) {
      data['trackingCode'] = trackingCode;
    }
    if (paymentStatus != null) {
      data['paymentStatus'] = paymentStatus!.value;
    }
    if (shippingFee != null) {
      data['shippingFee'] = shippingFee;
    }
    return data;
  }
}
