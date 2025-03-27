import 'package:flutter_modular/flutter_modular.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../features.dart';

import '../home/components/header.dart';
import 'components/components.dart';

typedef HandlePressedItem = void Function(UserPackage);

class BoxSectionScreen extends StatefulWidget {
  final int? initialTabIndex;

  const BoxSectionScreen({
    Key? key,
    this.initialTabIndex,
  }) : super(key: key);

  @override
  _BoxSectionScreenState createState() => _BoxSectionScreenState();
}

class _BoxSectionScreenState extends State<BoxSectionScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _controller = Modular.get<TotalItemsController>();

  final _searchFormFields = FormFields();

  final _tabsDataController = Modular.get<BoxSectionController>();
  final _tabsPaymentController = Modular.get<BoxSectionController>();
  final _tabsSendDataController = Modular.get<BoxSectionController>();

  @override
  void initState() {
    _controller.init();
    _startListener();

    super.initState();
  }

  void _startListener() {
    _controller.tabSectionIndex.listen(
      (currentIndex) => _setupListUserPackageList(
        UserParameters.values[currentIndex],
      ),
    );
  }

  void _setupListUserPackageList(UserParameters params) {
    switch (params) {
      case UserParameters.created:
        _tabsDataController.init(params);
        break;
      case UserParameters.paid:
        _tabsPaymentController.init(params);
        break;
      case UserParameters.sent:
        _tabsSendDataController.init(params);
        break;
    }
  }

  void _handleSearchCustomers() {
    final currentIndex = _controller.currentIndex;
    final params = UserParameters.values[currentIndex];

    final searchText = _searchFormFields.getText ?? '';
    switch (params) {
      case UserParameters.created:
        _tabsDataController.handleSearchCustomersList(searchText);
        break;
      case UserParameters.paid:
        _tabsPaymentController.handleSearchCustomersList(searchText);
        break;
      case UserParameters.sent:
        _tabsSendDataController.handleSearchCustomersList(searchText);
        break;
    }
  }

  void _openNavBar() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _navigateToPackageDetails(
    UserPackage package,
    PackageEditSection section,
  ) {
    _controller.navigateToPackageDetails(
      params: PackageDetailsParams(
        packageEditSection: section,
        packageID: package.packageId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: widget.initialTabIndex ?? 0,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: _scaffoldKey,
          body: _body(),
          drawer: _navBarWidget(),
        ),
      ),
    );
  }

  PreferredSizeWidget _header() {
    return Header(
      height: 100,
      padding: Paddings.zero,
      useAddicionalInformation: true,
      child: TotalItens(
        controller: _controller,
      ),
      openNavBar: _openNavBar,
    );
  }

  Widget _navBarWidget() {
    return const NavBarWidget();
  }

  Widget _body() {
    return BodyContentScreen(
      padding: Paddings.contentBodyOnly,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(),
          _searchField(),
          const VerticalSpacing(height: 16),
          HeaderTab(
            onChange: _controller.onChangeCurrentIndexState,
          ),
          const VerticalSpacing(height: 27),
          _tabs(),
        ],
      ),
    );
  }

  Widget _searchField() {
    return SearchComponent(
      fields: _searchFormFields,
      onPressed: _handleSearchCustomers,
    );
  }

  Widget _tabs() {
    return Expanded(
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          TabsData(
            controller: _tabsDataController,
            onPressed: (package) => _navigateToPackageDetails(
              package,
              PackageEditSection.shippingFee,
            ),
          ),
          TabsPaymentData(
            controller: _tabsPaymentController,
            onPressed: (package) => _navigateToPackageDetails(
              package,
              PackageEditSection.checkPayment,
            ),
          ),
          TabsSentData(
            controller: _tabsSendDataController,
            onPressed: (package) => _navigateToPackageDetails(
              package,
              PackageEditSection.trackingCode,
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabsDataController.dispose();
    _tabsPaymentController.dispose();
    _tabsSendDataController.dispose();
    _scaffoldKey.currentState?.dispose();
    _controller.dispose();
    _scaffoldKey.currentState?.dispose();
    super.dispose();
  }
}
