import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

abstract class TotalItemsController {
  Stream<int> get tabSectionIndex;
  Stream<int> get itensCountStream;

  int get currentIndex;

  void onChangeCurrentIndexState(int value);
  void navigateToPackageDetails({required PackageDetailsParams params});

  void init();
  void dispose();
}

class TotalItemsControllerImpl implements TotalItemsController {
  final AuthRepository repository;

  TotalItemsControllerImpl({
    required this.repository,
  });

  final _totalItemsSubject = BehaviorSubject<int>();
  final _currentIndexSubject = BehaviorSubject<int>.seeded(0);

  @override
  Stream<int> get itensCountStream => _totalItemsSubject.stream.distinct();

  @override
  Stream<int> get tabSectionIndex => _currentIndexSubject.stream.distinct();

  @override
  int get currentIndex => _currentIndexSubject.valueOrNull ?? 0;

  @override
  void init() async {
    await loadingTotalItems();
  }

  @override
  void onChangeCurrentIndexState(int newState) {
    if (!_currentIndexSubject.isClosed) {
      _currentIndexSubject.add(newState);
    }
  }

  void onChangeTotalItemsState(int newState) {
    if (!_totalItemsSubject.isClosed) {
      _totalItemsSubject.add(newState);
    }
  }

  Future<void> loadingTotalItems() async {
    try {
      final result = await repository.getTotalItens();
      onChangeTotalItemsState(result);
    } catch (_) {}
  }

  @override
  void navigateToPackageDetails({required PackageDetailsParams params}) {
    Modular.to.navigate(
      RoutesName.packageDetail.packageDetailsById(params.packageID),
      arguments: params.packageEditSection,
    );
  }

  @override
  void dispose() {
    _totalItemsSubject.close();
    _currentIndexSubject.close();
  }
}
