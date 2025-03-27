import 'package:flutter_modular/flutter_modular.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';
import 'components/customers_header.dart';
import 'customers.dart';
import 'models/paginate.dart';
import 'states/customers_list_state.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({Key? key}) : super(key: key);

  @override
  _CustomersScreenState createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _controller = Modular.get<CustomersController>();

  @override
  void initState() {
    _controller.init();
    super.initState();
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
    return StreamBuilder<CustomersListState>(
      stream: _controller.customesStateStream,
      builder: (context, snapshot) {
        final states = snapshot.data;

        if (states is CustomersListErrorState) {
          return _errorState(states.message);
        }

        if (states is CustomersListLoadingState) {
          return _loading();
        }

        if (states is CustomersListSucessState) {
          return _content(states.customes);
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
    return ErrorText(
      height: 500,
      imageSize: 180,
      message: message,
      colorText: AppColors.secondary,
    );
  }

  Widget _content(CustomersList listOfCustomes) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomersHeader(
          totalValue: listOfCustomes.length,
        ),
        const VerticalSpacing(
          height: 24,
        ),
        _lisOfCustumers(listOfCustomes),
      ],
    );
  }

  Widget _lisOfCustumers(CustomersList listOfCustomes) {
    if (listOfCustomes.isEmpty) {
      return const EmptyBoxIllustration(
        message: Strings.noRegisteredCustomer,
      );
    }

    return ListOfCustomers(
      list: listOfCustomes,
      onPressed: _controller.navigateToCreateItemsScreen,
    );
  }

  // ignore: unused_element
  Widget _paginate() {
    return StreamBuilder<Paginate?>(
      stream: _controller.paginateStream,
      builder: (context, snapshot) {
        final paginate = snapshot.data;

        if (paginate == null) {
          return Container();
        }

        return ListPaginate(
          nextPage: _controller.nextPage,
          totalPage: paginate.totalPage,
          currentPage: paginate.currentPage,
          previusPage: _controller.previusPage,
          onChangeCurrentPage: _controller.onChangeCurrentPage,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
