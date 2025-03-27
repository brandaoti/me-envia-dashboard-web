import 'package:rxdart/rxdart.dart';

import '../../core/core.dart';

import 'states/change_interval_type.dart';
import 'states/dollar_state.dart';
import 'states/home_state.dart';

abstract class HomeController {
  Stream<DollarState> get dollarState;
  Stream<HomeState> get homeStateStream;
  Stream<ReportInterval> get reportIntervalStream;

  void handleUpdatereportIntervale({
    required DateTime newDate,
    required ChangeIntervalType type,
  });

  Future<void> createNewQuotation(double money);

  void init();
  void dispose();
}

class HomeControllerImpl implements HomeController {
  final AuthRepository repository;

  HomeControllerImpl({
    required this.repository,
  });

  final homeStateSubject = BehaviorSubject<HomeState>.seeded(
    const HomeLoadingState(),
  );

  final dollarStateSubject = BehaviorSubject<DollarState>.seeded(
    const DollarLoadingState(),
  );

  final reportIntervalSubject = BehaviorSubject<ReportInterval>.seeded(
    ReportInterval.inital(),
  );

  @override
  Stream<HomeState> get homeStateStream => homeStateSubject.stream.distinct();

  @override
  Stream<ReportInterval> get reportIntervalStream =>
      reportIntervalSubject.stream.distinct();

  @override
  Stream<DollarState> get dollarState => dollarStateSubject.stream.distinct();

  @override
  void init() async {
    await loadReport();
    await getQuotation();
  }

  void onChangeHomeState(HomeState newState) {
    if (!homeStateSubject.isClosed) {
      homeStateSubject.add(newState);
    }
  }

  void onChangeInterval(ReportInterval newState) {
    if (!reportIntervalSubject.isClosed) {
      reportIntervalSubject.add(newState);
    }
  }

  Future<void> loadReport() async {
    onChangeHomeState(const HomeLoadingState());

    try {
      final interval = reportIntervalSubject.valueOrNull;

      final result = await repository.getAllReport(
        interval: interval ?? ReportInterval.inital(),
      );

      final status = handleFilterStatusList(result.status.toList());
      onChangeHomeState(HomeSucessState(
        report: result.copyWith(
          status: status.isEmpty ? result.status : status,
        ),
      ));
    } on ApiClientError catch (e) {
      onChangeHomeState(HomeErrorState(
        message: e.message ?? '',
      ));
    }
  }

  ReportStatusList handleFilterStatusList(ReportStatusList status) {
    final statusDelivered = status.getCountValue(3);
    final statusAwaitPayment = status.getCountValue(1);

    status.removeByStatus(1).removeByStatus(3);

    return [
      statusDelivered,
      statusAwaitPayment,
      ...status,
    ];
  }

  @override
  void handleUpdatereportIntervale({
    required DateTime newDate,
    required ChangeIntervalType type,
  }) {
    final currentDate = reportIntervalSubject.valueOrNull;

    switch (type) {
      case ChangeIntervalType.initialDate:
        onChangeInterval(ReportInterval(
          initialDate: newDate,
          finalDate: currentDate!.finalDate,
        ));
        break;
      case ChangeIntervalType.finalDate:
        onChangeInterval(ReportInterval(
          finalDate: newDate,
          initialDate: currentDate!.initialDate,
        ));
        break;
    }

    init();
  }

  void onChangeDollarState(DollarState newState) {
    if (!dollarStateSubject.isClosed) {
      dollarStateSubject.add(newState);
    }
  }

  Future<void> getQuotation() async {
    onChangeDollarState(const DollarLoadingState());

    try {
      final quotation = await repository.getQuotation();
      onChangeDollarState(DollarSucessState(quotation));
    } on ApiClientError catch (e) {
      onChangeDollarState(DollarErrorState(
        message: e.message ?? '',
      ));
    }
  }

  @override
  Future<void> createNewQuotation(double money) async {
    onChangeDollarState(const DollarLoadingState());

    try {
      await repository.createNewDollarQuotation(money);
      await getQuotation();
    } on ApiClientError catch (e) {
      onChangeDollarState(DollarErrorState(
        message: e.message ?? '',
      ));
    }
  }

  @override
  void dispose() {
    dollarStateSubject.close();
    homeStateSubject.close();
    reportIntervalSubject.close();
  }
}
