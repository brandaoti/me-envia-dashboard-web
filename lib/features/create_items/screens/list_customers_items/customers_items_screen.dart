import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/core.dart';
import '../../create_items.dart';
import '../../states/customers_items_states.dart';

class CustomersItems extends StatefulWidget {
  final Customers customers;

  const CustomersItems({
    Key? key,
    required this.customers,
  }) : super(key: key);

  @override
  _CustomersItemsState createState() => _CustomersItemsState();
}

class _CustomersItemsState extends State<CustomersItems> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _controller = Modular.get<CreateItemsController>();

  @override
  void initState() {
    _controller.init(customer: widget.customers);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scaffoldKey.currentState?.dispose();
    super.dispose();
  }

  void _showCreateNewItem() {
    ModalAddNewItem(
      context: context,
      customers: widget.customers,
    ).show();
  }

  void _showPreviewImage(List data) {
    ModalPreviewImages(
      context: context,
      box: data.last as Box,
      index: data.first as int,
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: BodyContentScreen(
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return StreamBuilder<CustomersItemsState>(
      stream: _controller.customesItemsStateStream,
      builder: (context, snapshot) {
        final states = snapshot.data;

        if (states is CustomesItemsErrorState) {
          return _errorState(states.message);
        }

        if (states is CustomersItemsLoadingState) {
          return _loading();
        }

        if (states is CustomesItemsSucessState) {
          return _content(states.userItems);
        }

        return Container();
      },
    );
  }

  Widget _loading() {
    return const Center(
      child: Loading(),
    );
  }

  Widget _errorState(String? message) {
    return Center(
      child: ErrorText(
        icon: null,
        fontSize: 24,
        message: message,
        isConfirmError: true,
        onConfirm: _controller.loadCustumersItems,
      ),
    );
  }

  Widget _content(UserItems userItems) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _title(userItems.user),
          const VerticalSpacing(
            height: 40,
          ),
          _rowContent(userItems),
        ],
      ),
    );
  }

  Widget _rowContent(UserItems userItems) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: _header(userItems.user),
        ),
        const HorizontalSpacing(
          width: 24,
        ),
        Expanded(
          flex: 2,
          child: _listOfItems(userItems.items),
        ),
      ],
    );
  }

  Widget _title(User user) {
    return SizedBox(
      width: double.infinity,
      child: AutoSizeText(
        user.name,
        maxLines: 1,
        minFontSize: 38,
        style: TextStyles.noConnectionTitle.copyWith(
          color: AppColors.secondary,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _header(User user) {
    return HeaderCreateItems(
      user: user,
    );
  }

  Widget _listOfItems(BoxList boxList) {
    return ListOfItems(
      list: boxList,
      onView: _showPreviewImage,
      onCreateNewItem: _showCreateNewItem,
    );
  }
}
