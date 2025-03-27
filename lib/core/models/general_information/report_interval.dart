import '../../values/durations.dart';

class ReportInterval {
  final DateTime finalDate;
  final DateTime initialDate;

  const ReportInterval({
    required this.finalDate,
    required this.initialDate,
  });

  factory ReportInterval.inital() {
    final now = DateTime.now();
    return ReportInterval(
      finalDate: now,
      initialDate: now.subtract(Durations.reportInterval),
    );
  }

  factory ReportInterval.fromInitialDate(DateTime date) {
    final now = DateTime.now();
    assert(
      date.difference(now).inDays <= 0,
      'The start date of the report must be less than or equal to the end date.',
    );

    return ReportInterval(
      finalDate: now,
      initialDate: date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'initialDate': initialDate,
      'finalDate': finalDate,
    };
  }

  ReportInterval copyWith({
    DateTime? initialDate,
    DateTime? finalDate,
  }) {
    return ReportInterval(
      initialDate: initialDate ?? this.initialDate,
      finalDate: finalDate ?? this.finalDate,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReportInterval &&
        other.initialDate == initialDate &&
        other.finalDate == finalDate;
  }

  @override
  int get hashCode => initialDate.hashCode ^ finalDate.hashCode;

  @override
  String toString() =>
      'ReportInterval(initialDate: $initialDate, finalDate: $finalDate)';
}
