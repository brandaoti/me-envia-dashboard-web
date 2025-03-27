import 'package:rxdart/rxdart.dart';

import '../../../../core/core.dart';

import '../../states/load_package_itens_state.dart';
import '../../states/shipping_fees_state.dart';

abstract class ShippingFeeController {
  Stream<ShippingFeeState> get shippingFeeStateStream;
  Stream<LoadPackageItensState> get loadPackageItensStateStream;

  double? getShippingFeeValue();

  void onChangeShippingFeeValue(double value);

  Future<void> updateShippingFeeValue({
    required String packageId,
  });
  Future<void> loadPackagesItens(String packageId);

  void init(
    double? shippingFee, {
    String? packageId,
  });
  void dispose();
}

class ShippingFeeControllerImpl implements ShippingFeeController {
  final AuthRepository repository;

  ShippingFeeControllerImpl({
    required this.repository,
  });

  final _shippingFeeStateSubject = BehaviorSubject<ShippingFeeState>.seeded(
    const ShippingFeeInitialState(),
  );

  final _loadPackageItensStateSubject =
      BehaviorSubject<LoadPackageItensState>.seeded(
    const LoadPackageItensLoadingState(),
  );

  double? shippingFeeValue;

  @override
  Stream<ShippingFeeState> get shippingFeeStateStream =>
      _shippingFeeStateSubject.stream.distinct();

  @override
  Stream<LoadPackageItensState> get loadPackageItensStateStream =>
      _loadPackageItensStateSubject.stream.distinct();

  @override
  void init(double? shippingFee, {String? packageId}) {
    if (shippingFee != null && shippingFee > 0) {
      shippingFeeValue = shippingFee;

      onChangeShippingFeesState(ShippingFeeSuccessState(
        shippingFee: shippingFeeValue!,
      ));
    }
    if (packageId != null) {
      loadPackagesItens(packageId);
    }
  }

  void onChangeShippingFeesState(ShippingFeeState newState) {
    if (!_shippingFeeStateSubject.isClosed) {
      _shippingFeeStateSubject.add(newState);
    }
  }

  void onLoadPackageItensState(LoadPackageItensState newState) {
    if (!_loadPackageItensStateSubject.isClosed) {
      _loadPackageItensStateSubject.add(newState);
    }
  }

  @override
  Future<void> loadPackagesItens(String packageId) async {
    try {
      final result = await repository.getPackage(
        packageId: packageId,
      );

      onLoadPackageItensState(
        LoadPackageItensSuccessState(boxList: result.packageItem),
      );
    } on ApiClientError catch (e) {
      onLoadPackageItensState(
        LoadPackageItensErrorState(message: e.message),
      );
    }
  }

  @override
  double? getShippingFeeValue() {
    return shippingFeeValue;
  }

  @override
  void onChangeShippingFeeValue(double value) {
    shippingFeeValue = value;
  }

  @override
  Future<void> updateShippingFeeValue({required String packageId}) async {
    onChangeShippingFeesState(const ShippingFeeLoadingState());

    try {
      await repository.updatePackage(
        packageId: packageId,
        update: UpdatePackage(shippingFee: shippingFeeValue?.byCents() ?? 0),
      );

      onChangeShippingFeesState(ShippingFeeSuccessState(
        shippingFee: shippingFeeValue ?? 0,
      ));
    } on ApiClientError catch (e) {
      onChangeShippingFeesState(ShippingFeeErrorState(
        message: e.message ?? '',
      ));
    } catch (e) {
      onChangeShippingFeesState(const ShippingFeeErrorState(
        message: Strings.errorUnknownInApi,
      ));
    }
  }

  @override
  void dispose() {
    _shippingFeeStateSubject.close();
  }
}
