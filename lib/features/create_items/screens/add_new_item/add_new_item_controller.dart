import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/core.dart';
import '../../create_items.dart';
import '../../states/create_customers_items_state.dart';

abstract class AddNewItemController extends Disposable {
  Stream<CreateItemType> get typeStateStream;
  Stream<CustomersItemsList> get itemsStateStream;
  Stream<OpenPhotoFileState> get openFileStateStream;
  Stream<CreateCustomersItemsState> get createItemStateStream;

  void onChangeCreateTypeState(CreateItemType newState);
  void onChangeOpenFileState(OpenPhotoFileState newState);

  void handleRemoveItem(CustomersItem item);

  Future<void> handleGetFileInDocument();
  bool handleAddNewItem({
    String? optinalItemName,
    String? customersItemId,
  });

  Future<void> handleCreateCustomerItem(String customersId);
}

class AddNewItemControllerImpl implements AddNewItemController {
  final PutFileService service;
  final AuthRepository repository;

  AddNewItemControllerImpl({
    required this.service,
    required this.repository,
  });

  PutFileImage? putFile;
  final Uuid uuid = const Uuid();

  final _itemsStatesSuject = BehaviorSubject<CustomersItemsList>.seeded(
    [],
  );

  final _openFileSuject = BehaviorSubject<OpenPhotoFileState>.seeded(
    const OpenPhotoFileInitalState(),
  );

  final _createTypeSuject = BehaviorSubject<CreateItemType>.seeded(
    CreateItemType.create,
  );

  final _createCustomersItemSuject =
      BehaviorSubject<CreateCustomersItemsState>();

  @override
  Stream<OpenPhotoFileState> get openFileStateStream =>
      _openFileSuject.stream.distinct();

  @override
  Stream<CustomersItemsList> get itemsStateStream =>
      _itemsStatesSuject.stream.distinct();

  @override
  Stream<CreateItemType> get typeStateStream =>
      _createTypeSuject.stream.distinct();

  @override
  Stream<CreateCustomersItemsState> get createItemStateStream =>
      _createCustomersItemSuject.stream.distinct();

  @override
  void onChangeOpenFileState(OpenPhotoFileState newState) {
    if (!_openFileSuject.isClosed) {
      _openFileSuject.add(newState);
    }
  }

  @override
  Future<void> handleGetFileInDocument() async {
    try {
      putFile = await service.getFile(ignore: PutFileType.pdf) as PutFileImage;
      onChangeOpenFileState(OpenPhotoFileSucessState(
        putFile: putFile!,
      ));
    } on ApiClientError catch (e) {
      onChangeOpenFileState(OpenPhotoFileErrorState(
        message: e.message ?? '',
      ));
    }
  }

  void onChangeCustomersItemsList(CustomersItemsList newState) {
    if (!_itemsStatesSuject.isClosed) {
      _itemsStatesSuject.add(newState);
    }
  }

  @override
  void onChangeCreateTypeState(CreateItemType newState) {
    if (!_createTypeSuject.isClosed) {
      _createTypeSuject.add(newState);
    }
  }

  @override
  bool handleAddNewItem({
    String? optinalItemName,
    String? customersItemId,
  }) {
    if (putFile == null) {
      onChangeOpenFileState(const OpenPhotoFileErrorState(
        message: Strings.addMoreOneFile,
      ));

      return false;
    }

    final type = _createTypeSuject.valueOrNull ?? CreateItemType.create;

    switch (type) {
      case CreateItemType.create:
        _handleCreateItem(optinalItemName);
        break;
      case CreateItemType.edit:
        _handleUpateItem(customersItemId ?? '', optinalItemName);
        break;
    }

    putFile = null;
    return true;
  }

  void _handleCreateItem(String? optinalItemName) {
    final newItem = CustomersItem(
      id: uuid.v4(),
      file: putFile,
      name: optinalItemName,
    );

    final listItems = _itemsStatesSuject.valueOrNull ?? [];
    onChangeCustomersItemsList([...listItems, newItem]);
  }

  void _handleUpateItem(
    String customersItemId,
    String? optinalItemName,
  ) {
    final listItems = _itemsStatesSuject.valueOrNull ?? [];

    final index = listItems.indexWhere(
      (it) => it.id.compareTo(customersItemId) == 0,
    );

    listItems[index] = CustomersItem(
      id: uuid.v4(),
      file: putFile,
      name: optinalItemName,
    );

    onChangeCustomersItemsList([...listItems]);
  }

  @override
  void handleRemoveItem(CustomersItem item) {
    final listItems = _itemsStatesSuject.valueOrNull ?? [];

    listItems.removeWhere((it) => item.id.compareTo(it.id) == 0);
    onChangeCustomersItemsList([...listItems]);

    onChangeCreateTypeState(CreateItemType.create);
    putFile = null;
  }

  void onChangeCreateCustomersItemsState(CreateCustomersItemsState newState) {
    if (!_createCustomersItemSuject.isClosed) {
      _createCustomersItemSuject.add(newState);
    }
  }

  @override
  Future<void> handleCreateCustomerItem(String customersId) async {
    onChangeCreateCustomersItemsState(const CreateCustomersItemsLoadingState());

    try {
      final list = _itemsStatesSuject.valueOrNull ?? [];

      final items = list.map((it) => it.toApi()).toList();
      await repository.createPackageMultiItem(
        userId: customersId,
        items: items,
      );

      onChangeCreateCustomersItemsState(
        const CreateCustomersItemsSucessState(),
      );
    } on ApiClientError catch (e) {
      onChangeCreateCustomersItemsState(CreateCustomersItemsErrorState(
        message: e.message ?? '',
      ));
    }
  }

  @override
  void dispose() {
    _openFileSuject.close();
    _createTypeSuject.close();
    _itemsStatesSuject.close();
    _createCustomersItemSuject.close();
  }
}
