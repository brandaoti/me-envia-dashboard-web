import '../../../core/models/models.dart';

abstract class HomeState {}

class HomeLoadingState implements HomeState {
  const HomeLoadingState();
}

class HomeSucessState implements HomeState {
  final ReportBoxs report;

  const HomeSucessState({
    required this.report,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeSucessState && other.report == report;
  }

  @override
  int get hashCode => report.hashCode;

  @override
  String toString() => 'HomeSucessState(report: $report)';
}

class HomeErrorState implements HomeState {
  final String message;

  const HomeErrorState({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
