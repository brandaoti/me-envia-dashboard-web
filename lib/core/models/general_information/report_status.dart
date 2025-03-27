import '../../types/types.dart';

typedef ReportStatusList = List<ReportStatus>;

class ReportStatus {
  final int count;
  final String labelStatus;
  final ReportStatusType status;

  const ReportStatus({
    required this.count,
    required this.labelStatus,
    required this.status,
  });

  factory ReportStatus.fromJson(Map json) {
    return ReportStatus(
      labelStatus: json['status'],
      count: int.parse(json['count']),
      status: (json['status'] as String).fromReportStatusType,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReportStatus &&
        other.count == count &&
        other.status == status;
  }

  @override
  int get hashCode => count.hashCode ^ status.hashCode;

  @override
  String toString() =>
      'ReportStatus(count: $count, labelStatus: $labelStatus, status: $status)';
}
