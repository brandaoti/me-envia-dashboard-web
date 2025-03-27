import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

import '../../states/load_payment_voucher_state.dart';
import '../../models/proof_of_payment_state.dart';
import '../../states/update_payment_status.dart';
import '../../states/check_payment_state.dart';
import '../../package_details.dart';

class CheckPayment extends StatefulWidget {
  final Package package;
  final PackageEditSection packageEditSection;

  const CheckPayment({
    Key? key,
    required this.package,
    required this.packageEditSection,
  }) : super(key: key);

  @override
  _CheckPaymentState createState() => _CheckPaymentState();
}

class _CheckPaymentState extends State<CheckPayment> {
  final _controller = Modular.get<CkeckPaymentController>();

  @override
  void initState() {
    _controller.init(
      package: widget.package,
      packageEditSection: widget.packageEditSection,
    );

    _startListener();
    super.initState();
  }

  void _startListener() {
    _controller.loadPaymentVoucherStateStream.listen((states) {
      if (states is LoadPaymentVoucherErrorState) {
        _showSnackBar();
      }
    });

    _controller.updatePaymenStatusStream.listen((states) {
      if (states is UpdatePaymentErrorStatus) {
        _showSnackBar(
          message: states.message ?? Strings.errorUnknownInApi,
        );
      }
    });
  }

  void _showSnackBar({String message = Strings.errorInDownloadPaymentFile}) {
    Helper.showSnackBarCopiedToClipboard(
      context,
      message,
      duration: Durations.transitionDownload,
      backgroundColor: AppColors.alertRedColor,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDownloadFile() {
    _controller.handleDownloadProoOfPayment(
      widget.package.paymentVoucher ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            fontSize: 24,
            color: AppColors.grey500,
            title: Strings.paymentTitle,
          ),
          const VerticalSpacing(
            height: 16,
          ),
          _body(),
        ],
      ),
    );
  }

  Widget _body() {
    return StreamBuilder<CheckPaymentState>(
      stream: _controller.checkPaymentStateStream,
      builder: (context, snapshot) {
        final states = snapshot.data;

        late final ProofOfPaymentState proofOfPaymentState;

        if (states == null || states is CheckPaymentAllDisableState) {
          proofOfPaymentState = ProofOfPaymentState.disable();
        }

        if (states is CheckPaymentInitialState) {
          const message = Strings.awaitProofOfPayment;
          proofOfPaymentState = ProofOfPaymentState.initial(
            message: states.hasPaymentVoucher ? null : message,
            iconVisible: states.hasPaymentVoucher ? null : false,
            isButtonsEnabled: states.hasPaymentVoucher ? null : false,
          );
        }

        if (states is CheckPaymentSucessState) {
          proofOfPaymentState = ProofOfPaymentState.sucess();
        }

        if (states is CheckPaymentErrorState) {
          proofOfPaymentState = ProofOfPaymentState.error(
            message: states.message,
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _proofOfPaymentStatus(
              message: proofOfPaymentState.message,
              primary: proofOfPaymentState.primary,
              iconVisible: proofOfPaymentState.iconVisible,
              isButtonsEnabled: proofOfPaymentState.isButtonsEnabled,
            ),
            _progrssDowloadFileStates(),
            const VerticalSpacing(
              height: 16,
            ),
            _actionsButton(
              isButtonsEnabled: proofOfPaymentState.isButtonsEnabled,
            ),
          ],
        );
      },
    );
  }

  Widget _progrssDowloadFileStates() {
    return StreamBuilder<LoadPaymentVoucherState>(
      stream: _controller.loadPaymentVoucherStateStream,
      builder: (context, snapshot) {
        final states = snapshot.data;

        if (states is LoadPaymentVoucherLoadingState) {
          return _progrssDowloadFile(states.progress);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _progrssDowloadFile(double progress) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: LinearProgressIndicator(
        value: progress / 100,
        backgroundColor: AppColors.primary.withOpacity(0.2),
        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
      ),
    );
  }

  Widget _proofOfPaymentStatus({
    required Color primary,
    required String message,
    required bool iconVisible,
    required bool isButtonsEnabled,
  }) {
    final decoration = Decorations.checkPayment(primary: primary);

    return InkWell(
      onTap: isButtonsEnabled ? _handleDownloadFile : null,
      borderRadius: decoration.borderRadius as BorderRadius,
      child: Container(
        height: 130,
        width: double.infinity,
        decoration: decoration,
        alignment: Alignment.center,
        child: _proofOfPaymentStatusItem(
          iconVisible: iconVisible,
          message: message,
          primary: primary,
        ),
      ),
    );
  }

  Widget _proofOfPaymentStatusItem({
    required Color primary,
    required String message,
    required bool iconVisible,
  }) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 240),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            MdiIcons.fileDocumentOutline,
            color: primary,
            size: Dimens.orderCardProfileSize,
          ),
          Expanded(
            child: _proofOfPaymentStatusMessage(
              primary: primary,
              message: message,
            ),
          ),
          Visibility(
            visible: iconVisible,
            child: const Icon(
              Icons.download_rounded,
              color: AppColors.black,
              size: Dimens.orderCardProfileSize / 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _proofOfPaymentStatusMessage({
    required Color primary,
    required String message,
  }) {
    return Padding(
      padding: Paddings.horizontalSmall,
      child: AutoSizeText(
        message,
        style: TextStyles.checkPayment(primary: primary),
      ),
    );
  }

  Widget _actionsButton({
    required bool isButtonsEnabled,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = (constraints.maxWidth / 2) - Dimens.vertical;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _recusePaymentButton(
              maxWidth: maxWidth,
              isEnabled: isButtonsEnabled,
            ),
            const HorizontalSpacing(
              width: Dimens.vertical,
            ),
            _toApprovePaymentButton(
              maxWidth: maxWidth,
              isEnabled: isButtonsEnabled,
            ),
          ],
        );
      },
    );
  }

  Widget _recusePaymentButton({
    required double maxWidth,
    bool isLoading = false,
    bool isEnabled = false,
  }) {
    return StreamBuilder<UpdatePaymentStatus>(
      stream: _controller.updatePaymenStatusStream,
      builder: (context, snapshot) {
        final states = snapshot.data;
        bool isAllLoading = isLoading;

        if (states is UpdatePaymentLoadingStatus) {
          isAllLoading = states.isRecusedSectionInLoading;
        }

        return ConstrainedBox(
          constraints: Sizes.checkPayment(maxWidth),
          child: RoundedButton(
            isValid: isEnabled,
            isLoading: isAllLoading,
            title: Strings.recusePayment,
            onPressed: () => _controller.handleUpdatePaymentStatus(1),
          ),
        );
      },
    );
  }

  Widget _toApprovePaymentButton({
    required double maxWidth,
    bool isEnabled = false,
    bool isLoading = false,
  }) {
    return StreamBuilder<UpdatePaymentStatus>(
      stream: _controller.updatePaymenStatusStream,
      builder: (context, snapshot) {
        final states = snapshot.data;
        bool isAllLoading = isLoading;

        if (states is UpdatePaymentLoadingStatus) {
          isAllLoading = !states.isRecusedSectionInLoading;
        }
        return ConstrainedBox(
          constraints: Sizes.checkPayment(maxWidth),
          child: DefaultButton(
            isValid: isEnabled,
            isLoading: isAllLoading,
            title: Strings.approvePayment,
            onPressed: () => _controller.handleUpdatePaymentStatus(0),
          ),
        );
      },
    );
  }
}
