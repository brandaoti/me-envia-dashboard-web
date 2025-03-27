import '../../helpers/extensions.dart';
import '../../types/types.dart';
import '../models.dart';

typedef PackageList = List<Package>;

class Package {
  final String id;
  final String userId;
  final String? status;
  final String? receiverCpf;
  final String? receiverName;
  final bool dropShipping;
  final PackageStep? step;
  final PackageType? type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double? shippingFee;
  final String? trackingCode;
  final String? paymentVoucher;
  final PaymentStatus? paymentStatus;
  final DeclarationList declarationList;
  final String? lastPackageUpdateLocation;

  const Package({
    required this.id,
    required this.userId,
    required this.status,
    required this.receiverCpf,
    required this.receiverName,
    required this.dropShipping,
    required this.step,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.shippingFee,
    required this.trackingCode,
    required this.paymentVoucher,
    required this.paymentStatus,
    required this.declarationList,
    required this.lastPackageUpdateLocation,
  });

  factory Package.fromJson(Map json) {
    final media = (json['paymentVoucher'] as String?);
    final declarations = (json['declaration'] as List);
    final dateCreate = DateTime.tryParse(json['createdAt']) ?? DateTime.now();
    final dateUpdate = DateTime.tryParse(json['updatedAt']) ?? DateTime.now();
    final listDeclarations =
        declarations.map((it) => Declaration.fromJson(it)).toList();

    double shippingFeeValue = 0;
    final shippingFeeType = json['shippingFee'];

    if (shippingFeeType is String) {
      shippingFeeValue = double.parse(json['shippingFee']);
    } else if (shippingFeeType is int) {
      shippingFeeValue = (json['shippingFee'] as int).toDouble();
    }

    return Package(
      id: json['id'],
      createdAt: dateCreate,
      updatedAt: dateUpdate,
      status: json['status'],
      userId: json['userId'],
      shippingFee: shippingFeeValue,
      receiverCpf: json['receiverCpf'],
      declarationList: listDeclarations,
      receiverName: json['receiverName'],
      dropShipping: json['dropShipping'],
      trackingCode: json['trackingCode'],
      step: (json['step'] as String?).fromApiStep,
      type: (json['type'] as String?).fromApiType,
      lastPackageUpdateLocation: json['lastPackageUpdateLocation'],
      paymentVoucher: media != null ? media.normalizePictureUrl : media,
      paymentStatus: (json['paymentStatus'] as String?).fromPaymentType,
    );
  }

  bool get isPackageStock => (trackingCode ?? '').isEmpty;

  String get fullAddressAndTrackingCode =>
      '${lastPackageUpdateLocation ?? ''} - $trackingCode';

  bool get hasPaymentVoucher {
    return paymentVoucher != null && paymentVoucher!.isNotEmpty;
  }

  bool get isAprrovatedPayment {
    return paymentStatus != null && paymentStatus == PaymentStatus.success;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Package &&
        other.id == id &&
        other.userId == userId &&
        other.status == status &&
        other.trackingCode == trackingCode &&
        other.paymentVoucher == paymentVoucher &&
        other.lastPackageUpdateLocation == lastPackageUpdateLocation &&
        other.shippingFee == shippingFee &&
        other.dropShipping == dropShipping &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.step == step &&
        other.type == type &&
        other.paymentStatus == paymentStatus &&
        other.declarationList == declarationList;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        status.hashCode ^
        trackingCode.hashCode ^
        paymentVoucher.hashCode ^
        lastPackageUpdateLocation.hashCode ^
        shippingFee.hashCode ^
        dropShipping.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        step.hashCode ^
        type.hashCode ^
        paymentStatus.hashCode ^
        declarationList.hashCode;
  }

  @override
  String toString() {
    return 'Package(id: $id, userId: $userId, status: $status, trackingCode: $trackingCode, paymentVoucher: $paymentVoucher, lastPackageUpdateLocation: $lastPackageUpdateLocation, shippingFee: $shippingFee, dropShipping: $dropShipping, createdAt: $createdAt, updatedAt: $updatedAt, step: $step, type: $type, paymentStatus: $paymentStatus, declarationList: $declarationList)';
  }
}
