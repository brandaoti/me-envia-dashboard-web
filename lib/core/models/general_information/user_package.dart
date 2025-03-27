import '../../types/types.dart';

typedef UserPackageList = List<UserPackage>;

class UserPackage {
  final String id;
  final String name;
  final String? count;
  final String packageId;
  final int? shippingFee;
  final PackageType? type;
  final PackageStep? step;
  final String? trackingCode;
  final PackageStatusType? status;
  final PaymentStatus? paymentStatus;

  const UserPackage({
    required this.id,
    required this.name,
    required this.count,
    required this.type,
    required this.step,
    required this.status,
    required this.packageId,
    required this.shippingFee,
    required this.trackingCode,
    required this.paymentStatus,
  });

  factory UserPackage.fromJson(Map json) {
    return UserPackage(
      id: json['id'],
      name: json['name'],
      count: json['count'],
      packageId: json['packageId'],
      shippingFee: json['shippingFee'],
      trackingCode: json['trackingCode'],
      step: (json['step'] as String?).fromApiStep,
      type: (json['type'] as String?).fromApiType,
      status: (json['status'] as String).fromStatusType,
      paymentStatus: (json['paymentStatus'] as String).fromPaymentType,
    );
  }

  bool get hasTrackingCode {
    return trackingCode != null && trackingCode!.isNotEmpty;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserPackage &&
        other.id == id &&
        other.name == name &&
        other.count == count &&
        other.packageId == packageId &&
        other.shippingFee == shippingFee &&
        other.type == type &&
        other.step == step &&
        other.trackingCode == trackingCode &&
        other.status == status &&
        other.paymentStatus == paymentStatus;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        count.hashCode ^
        packageId.hashCode ^
        shippingFee.hashCode ^
        type.hashCode ^
        step.hashCode ^
        trackingCode.hashCode ^
        status.hashCode ^
        paymentStatus.hashCode;
  }

  @override
  String toString() {
    return 'UserPackage(id: $id, name: $name, count: $count, packageId: $packageId, shippingFee: $shippingFee, type: $type, step: $step, trackingCode: $trackingCode, status: $status, paymentStatus: $paymentStatus)';
  }
}
