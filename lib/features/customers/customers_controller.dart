import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/core.dart';

import 'models/paginate.dart';
import 'states/customers_list_state.dart';

abstract class CustomersController {
  Stream<Paginate?> get paginateStream;
  Stream<CustomersListState> get customesStateStream;

  void onChangeCurrentPage(int newPage);

  void nextPage();
  void previusPage();

  void navigateToCreateItemsScreen(Customers customes);

  void init();
  void dispose();
}

class CustomersControllerImpl implements CustomersController {
  final AuthRepository repository;

  CustomersControllerImpl({
    required this.repository,
  });

  final _loadinCustumesSubject = BehaviorSubject<CustomersListState>.seeded(
    const CustomersListLoadingState(),
  );

  final _paginateSubject = BehaviorSubject<Paginate?>();

  @override
  Stream<CustomersListState> get customesStateStream =>
      _loadinCustumesSubject.stream.distinct();

  @override
  Stream<Paginate?> get paginateStream => _paginateSubject.stream.distinct();

  @override
  void init() async {
    await loadCustomes();
  }

  void onChangeLoadCustomesState(CustomersListState newState) {
    if (!_loadinCustumesSubject.isClosed) {
      _loadinCustumesSubject.add(newState);
    }
  }

  Future<void> loadCustomes() async {
    onChangeLoadCustomesState(const CustomersListLoadingState());

    try {
      final result = await repository.getAllCustomers();

      onChangeLoadCustomesState(CustomersListSucessState(
        customes: result,
      ));
    } on ApiClientError catch (e) {
      onChangeLoadCustomesState(CustomersListErrorState(
        message: e.message ?? '',
      ));
    }
  }

  void onChangePaginate(Paginate? paginate) {
    if (!_paginateSubject.isClosed) {
      _paginateSubject.add(paginate);
    }
  }

  @override
  void onChangeCurrentPage(int newPage) {
    final current = _paginateSubject.valueOrNull;
    onChangePaginate(current?.copyWith(currentPage: newPage));
  }

  @override
  void navigateToCreateItemsScreen(Customers customes) {
    Modular.to.navigate(
      RoutesName.listCustomesItems.name,
      arguments: customes,
    );
  }

  @override
  void nextPage() async {
    final actual = _paginateSubject.valueOrNull;

    if (actual == null) {
      return;
    }

    if (actual.currentPage < actual.totalPage) {
      onChangePaginate(actual.copyWith(
        currentPage: actual.currentPage + 1,
      ));

      await updateCustomesList(actual.currentPage);
    }
  }

  @override
  void previusPage() async {
    final actual = _paginateSubject.valueOrNull;

    if (actual == null) {
      return;
    }

    if (actual.currentPage > 1) {
      onChangePaginate(actual.copyWith(
        currentPage: actual.currentPage - 1,
      ));

      await updateCustomesList(actual.currentPage);
    }
  }

  Future<void> updateCustomesList(int page) async {}

  @override
  void dispose() {
    _paginateSubject.close();
    _loadinCustumesSubject.close();
  }
}
