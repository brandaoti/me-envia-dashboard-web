import 'package:rxdart/rxdart.dart';

import '../../../../core/core.dart';
import '../../package_details.dart';

import '../../states/load_payment_voucher_state.dart';
import '../../states/update_payment_status.dart';
import '../../states/check_payment_state.dart';

abstract class CkeckPaymentController {
  Stream<CheckPaymentState> get checkPaymentStateStream;
  Stream<UpdatePaymentStatus> get updatePaymenStatusStream;
  Stream<LoadPaymentVoucherState> get loadPaymentVoucherStateStream;

  Future<void> handleUpdatePaymentStatus(int status);
  Future<void> handleDownloadProoOfPayment(String urlPath);

  void init({
    required Package package,
    required PackageEditSection packageEditSection,
  });
  void dispose();
}

class CkeckPaymentControllerImpl implements CkeckPaymentController {
  final PutFileService service;
  final AuthRepository repository;

  CkeckPaymentControllerImpl({
    required this.service,
    required this.repository,
  });

  late final String packageId;

  final _proofOfPaymentSubject = BehaviorSubject<CheckPaymentState>.seeded(
    const CheckPaymentInitialState(),
  );

  final _loadProofOfPaymentSubject = BehaviorSubject<LoadPaymentVoucherState>();

  final _updatePaymentSubject = BehaviorSubject<UpdatePaymentStatus>();

  @override
  Stream<CheckPaymentState> get checkPaymentStateStream =>
      _proofOfPaymentSubject.stream.distinct();

  @override
  Stream<LoadPaymentVoucherState> get loadPaymentVoucherStateStream =>
      _loadProofOfPaymentSubject.stream.distinct();

  @override
  Stream<UpdatePaymentStatus> get updatePaymenStatusStream =>
      _updatePaymentSubject.stream.distinct();

  @override
  void init({
    required Package package,
    required PackageEditSection packageEditSection,
  }) {
    packageId = package.id;

    if (packageEditSection == PackageEditSection.shippingFee) {
      onChangeCheckPaymentState(const CheckPaymentAllDisableState());
      return;
    }

    if (package.isAprrovatedPayment) {
      onChangeCheckPaymentState(const CheckPaymentSucessState());
    } else {
      onChangeCheckPaymentState(CheckPaymentInitialState(
        hasPaymentVoucher: package.hasPaymentVoucher,
      ));
    }
  }

  void onChangeCheckPaymentState(CheckPaymentState newState) {
    if (!_proofOfPaymentSubject.isClosed) {
      _proofOfPaymentSubject.add(newState);
    }
  }

  void onChangeLoadPaymentVoucherState(LoadPaymentVoucherState newState) {
    if (!_loadProofOfPaymentSubject.isClosed) {
      _loadProofOfPaymentSubject.add(newState);
    }
  }

  @override
  Future<void> handleDownloadProoOfPayment(String urlPath) async {
    onChangeLoadPaymentVoucherState(const LoadPaymentVoucherLoadingState());

    try {
      final result = await repository.downloadProofOfPayment(
        urlFile: urlPath,
        progress: calculateDownloadProgress,
      );

      await service.saveProoOfPaymentInExternalPath(
        bytes: result,
        urlFile: urlPath,
      );

      onChangeLoadPaymentVoucherState(const LoadPaymentVoucherSucessState());
    } on ApiClientError catch (e) {
      onChangeLoadPaymentVoucherState(LoadPaymentVoucherErrorState(
        message: e.message ?? '',
      ));
    }
  }

  void calculateDownloadProgress(int received, int total) {
    if (total == -1) return;

    onChangeLoadPaymentVoucherState(LoadPaymentVoucherLoadingState(
      progress: received / total * 100,
    ));
  }

  void onChangeUpdatePaymentStatus(UpdatePaymentStatus newState) {
    if (!_updatePaymentSubject.isClosed) {
      _updatePaymentSubject.add(newState);
    }
  }

  @override
  Future<void> handleUpdatePaymentStatus(int status) async {
    onChangeUpdatePaymentStatus(UpdatePaymentLoadingStatus(
      isRecusedSectionInLoading: status == 1,
    ));

    try {
      final paymentStatus = PaymentStatus.values[status];
      await repository.updatePackage(
        packageId: packageId,
        update: UpdatePackage(paymentStatus: paymentStatus),
      );

      onChangeUpdatePaymentStatus(const UpdatePaymentSuccessStatus());
      handleUpdatePamentVouter(paymentStatus);
    } on ApiClientError catch (e) {
      onChangeUpdatePaymentStatus(UpdatePaymentErrorStatus(
        message: e.message ?? '',
      ));
    }
  }

  void handleUpdatePamentVouter(PaymentStatus status) {
    if (status == PaymentStatus.success) {
      onChangeCheckPaymentState(const CheckPaymentSucessState());
    } else {
      onChangeCheckPaymentState(const CheckPaymentErrorState());
    }
  }

  @override
  void dispose() {
    _updatePaymentSubject.close();
    _proofOfPaymentSubject.close();
    _loadProofOfPaymentSubject.close();
  }
}
