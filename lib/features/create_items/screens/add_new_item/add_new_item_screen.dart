import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/core.dart';
import '../../../features.dart';
import '../../states/create_customers_items_state.dart';

class AddNewItemScreen extends StatefulWidget {
  final Customers customers;

  const AddNewItemScreen({
    Key? key,
    required this.customers,
  }) : super(key: key);

  @override
  _AddNewItemScreenState createState() => _AddNewItemScreenState();
}

class _AddNewItemScreenState extends State<AddNewItemScreen> {
  final _pageController = PageController();
  final _controller = Modular.get<CreateItemsController>();
  final _addNewItemController = Modular.get<AddNewItemController>();

  final _optinalItemNameFormField = FormFields();

  CustomersItem? _onEditItem;

  @override
  void initState() {
    _controller.init(
      isLoadItems: false,
      customer: widget.customers,
    );

    _startListener();
    super.initState();
  }

  void _startListener() {
    _addNewItemController.createItemStateStream.listen((states) async {
      if (states is CreateCustomersItemsSucessState) {
        _animateToPage(2);

        await Future.delayed(Durations.transitionToNavigate);
        _controller.navigateToInitalScreen();
      }

      if (states is CreateCustomersItemsErrorState) {
        ActionToErrorState(
          subtitle: '',
          context: context,
          message: states.message,
        ).show();
      }
    });
  }

  void _clear() {
    _onEditItem = null;
    _optinalItemNameFormField.controller?.clear();
    _addNewItemController.onChangeCreateTypeState(CreateItemType.create);
    _addNewItemController
        .onChangeOpenFileState(const OpenPhotoFileInitalState());
  }

  void _handleAddNewItem() {
    final name = _optinalItemNameFormField.controller?.text;
    final isSucess = _addNewItemController.handleAddNewItem(
      optinalItemName: name,
      customersItemId: _onEditItem?.id,
    );

    if (isSucess) {
      _animateToPage(1);
      _clear();
    }
  }

  void _handleEditItem(CustomersItem item) {
    _optinalItemNameFormField.controller?.text = item.name ?? '';
    _addNewItemController.onChangeOpenFileState(OpenPhotoFileSucessState(
      putFile: item.file!,
    ));

    _onEditItem = item;
    _animateToPage(0);
    _addNewItemController.onChangeCreateTypeState(CreateItemType.edit);
  }

  void _handleRemoveItem() {
    if (_onEditItem == null) return;

    _addNewItemController.handleRemoveItem(_onEditItem!);
    _animateToPage(1);

    _clear();
  }

  void _onFinish() async {
    final customersId = _controller.getCustomesId();
    await _addNewItemController.handleCreateCustomerItem(customersId);
  }

  void _animateToPage(int page) {
    _pageController.animateToPage(
      page,
      curve: Curves.linear,
      duration: Durations.transition,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _body(),
    );
  }

  Widget _body() {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _addNewItem(),
        _listOfCreatedItems(),
        const ModalEditingCompleted(
          title: Strings.modalAddedItemTitle,
          subtitle: Strings.modalAddedItemMessage,
        ),
      ],
    );
  }

  Widget _addNewItem() {
    return StreamBuilder<CreateItemType>(
      stream: _addNewItemController.typeStateStream,
      builder: (context, snapshot) {
        final type = snapshot.data ?? CreateItemType.create;
        return CreateItemWidget(
          type: type,
          onRemoveItem: _handleRemoveItem,
          onConfirmAddItem: _handleAddNewItem,
          stream: _addNewItemController.openFileStateStream,
          optinalItemNameFormField: _optinalItemNameFormField,
          onOpenFile: _addNewItemController.handleGetFileInDocument,
        );
      },
    );
  }

  Widget _listOfCreatedItems() {
    return StreamBuilder<CustomersItemsList>(
      stream: _addNewItemController.itemsStateStream,
      builder: (context, snapshot) {
        return ListOfAddedIitems(
          onFinish: _onFinish,
          items: snapshot.data ?? [],
          onEditItem: _handleEditItem,
          createCustomersItemsStream:
              _addNewItemController.createItemStateStream,
          onAddNewItem: () {
            _animateToPage(0);
            _clear();
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    _addNewItemController.dispose();
    _optinalItemNameFormField.dispose();
    super.dispose();
  }
}
