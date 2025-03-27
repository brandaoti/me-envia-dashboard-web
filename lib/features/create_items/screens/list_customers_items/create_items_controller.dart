import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/repositories/repositories.dart';
import '../../states/customers_items_states.dart';
import '../../../../core/client/client.dart';
import '../../../../core/models/models.dart';
import '../../../../core/types/types.dart';

abstract class CreateItemsController {
  Stream<CustomersItemsState> get customesItemsStateStream;

  Future<void> loadCustumersItems();

  void navigateToInitalScreen();
  void navigateToCurrentScreen();

  String getCustomesId();

  void init({
    bool isLoadItems = true,
    required Customers customer,
  });
  void dispose();
}

class CreateItemsControllerImpl implements CreateItemsController {
  final AuthRepository repository;

  CreateItemsControllerImpl({
    required this.repository,
  });

  late final Customers customer;

  final _customesItemsSubject = BehaviorSubject<CustomersItemsState>.seeded(
    const CustomersItemsLoadingState(),
  );

  @override
  Stream<CustomersItemsState> get customesItemsStateStream =>
      _customesItemsSubject.stream.distinct();

  @override
  void init({
    bool isLoadItems = true,
    required Customers customer,
  }) async {
    this.customer = customer;

    if (isLoadItems) {
      await loadCustumersItems();
    }
  }

  void onChangeCustomesItemsState(CustomersItemsState newState) {
    if (!_customesItemsSubject.isClosed) {
      _customesItemsSubject.add(newState);
    }
  }

  @override
  Future<void> loadCustumersItems() async {
    onChangeCustomesItemsState(const CustomersItemsLoadingState());

    try {
      final result = await repository.getUserItems(userId: customer.id);

      onChangeCustomesItemsState(CustomesItemsSucessState(
        userItems: result,
      ));
    } on ApiClientError catch (e) {
      onChangeCustomesItemsState(CustomesItemsErrorState(
        message: e.message ?? '',
      ));
    }
  }

  @override
  void navigateToCurrentScreen() {
    Modular.to.navigate(
      RoutesName.listCustomesItems.name,
      arguments: customer,
    );
  }

  @override
  void navigateToInitalScreen() {
    Modular.to.navigate(
      RoutesName.customers.name,
    );
  }

  @override
  String getCustomesId() {
    return customer.id;
  }

  @override
  void dispose() {
    _customesItemsSubject.close();
  }
}
