import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';
import 'components/components.dart';
import 'home_controller.dart';

import 'states/change_interval_type.dart';
import 'states/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _controller = Modular.get<HomeController>();

  @override
  void initState() {
    _controller.init();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scaffoldKey.currentState?.dispose();
    super.dispose();
  }

  void _showModalUpdateDollar() {
    ModalUpdateDollar(
      context: context,
      controller: _controller,
    ).show();
  }

  void _showDatePicker(
    ChangeIntervalType type,
    DateTime initialDate,
  ) async {
    final now = DateTime.now();

    final DateTime? date = await showDatePicker(
      lastDate: now,
      context: context,
      confirmText: Strings.ok,
      initialDate: initialDate,
      cancelText: Strings.cancel,
      firstDate: now.subtract(Durations.lastReportInterval),
      builder: (context, child) => Theme(
        child: Container(child: child),
        data: AppTheme.setDatePickerTheme(),
      ),
    );

    if (date != null) {
      _controller.handleUpdatereportIntervale(newDate: date, type: type);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return StreamBuilder<HomeState>(
      stream: _controller.homeStateStream,
      builder: (context, snapshot) {
        final state = snapshot.data;

        if (state is HomeLoadingState) {
          return const Center(child: Loading());
        }

        if (state is HomeErrorState) {
          return _errorWidget(state.message);
        }

        if (state is HomeSucessState) {
          return _content(state.report);
        }

        return Container();
      },
    );
  }

  Widget _errorWidget(String message) {
    return Center(
      child: ErrorState(
        height: null,
        message: message,
        isButtonVisibility: true,
        onPressed: _controller.init,
        textAlign: TextAlign.center,
        padding: Paddings.horizontal,
      ),
    );
  }

  Widget _content(ReportBoxs report) {
    return BodyContentScreen(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 858),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _contentHeader(),
            const VerticalSpacing(
              height: 24,
            ),
            Expanded(
              child: _contentReport(report),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contentReport(ReportBoxs report) {
    return LayoutBuilder(
      builder: (context, constraints) => ConstrainedBox(
        constraints: constraints,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 3,
              child: _reportBoxs(
                statusList: report.status..sortByStatus,
              ),
            ),
            const HorizontalSpacing(
              width: 24,
            ),
            Flexible(
              flex: 2,
              child: _reportClients(report),
            ),
          ],
        ),
      ),
    );
  }

  Widget _reportClients(ReportBoxs report) {
    return Padding(
      padding: const EdgeInsets.only(top: 36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          PaymentReport(
            paymentReceived: report.paymentReceived,
            paymentToReceive: report.paymentToReceive,
          ),
          const VerticalSpacing(
            height: 24,
          ),
          ReportClientsAndBilling(
            billing: report.billing,
            totalCustomers: report.totalCustomers,
          ),
        ],
      ),
    );
  }

  Widget _contentHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const HeaderTitle(),
        _quotation(),
      ],
    );
  }

  Widget _quotation() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 140),
      child: DollarQuotation(
        controller: _controller,
        onPressed: _showModalUpdateDollar,
      ),
    );
  }

  Widget _reportBoxs({
    required ReportStatusList statusList,
  }) {
    return StreamBuilder<ReportInterval>(
      initialData: ReportInterval.inital(),
      stream: _controller.reportIntervalStream,
      builder: (context, snapshot) {
        final interval = snapshot.data!;

        return ReportBoxsWidget(
          reportStatusList: statusList,
          finalDate: interval.finalDate,
          onOpenDatePicker: _showDatePicker,
          initialDate: interval.initialDate,
        );
      },
    );
  }
}
