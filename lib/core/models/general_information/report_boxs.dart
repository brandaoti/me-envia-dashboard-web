import '../general_information/report_status.dart';

class ReportBoxs {
  final double billing;
  final int totalCustomers;
  final double paymentReceived;
  final double paymentToReceive;
  final ReportStatusList status;

  const ReportBoxs({
    required this.status,
    required this.billing,
    required this.totalCustomers,
    required this.paymentReceived,
    required this.paymentToReceive,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReportBoxs &&
        other.billing == billing &&
        other.totalCustomers == totalCustomers &&
        other.paymentReceived == paymentReceived &&
        other.paymentToReceive == paymentToReceive &&
        other.status == status;
  }

  @override
  int get hashCode {
    return billing.hashCode ^
        totalCustomers.hashCode ^
        paymentReceived.hashCode ^
        paymentToReceive.hashCode ^
        status.hashCode;
  }

  @override
  String toString() {
    return 'ReportBoxs(billing: $billing, totalCustomers: $totalCustomers, paymentReceived: $paymentReceived, paymentToReceive: $paymentToReceive, status: $status)';
  }

  ReportBoxs copyWith({
    double? billing,
    int? totalCustomers,
    double? totalBalance,
    double? paymentReceived,
    double? paymentToReceive,
    ReportStatusList? status,
  }) {
    return ReportBoxs(
      status: status ?? this.status,
      billing: billing ?? this.billing,
      totalCustomers: totalCustomers ?? this.totalCustomers,
      paymentReceived: paymentReceived ?? this.paymentReceived,
      paymentToReceive: paymentToReceive ?? this.paymentToReceive,
    );
  }
}
