import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/subjects.dart';

import '../../core/core.dart';

import 'states/load_package_state.dart';
import 'states/package_edit_section.dart';

abstract class PackageController extends Disposable {
  Stream<GetPackageState> get getPackageStateStream;
  void navigateToBoxSectionScreen(PackageEditSection packageEditSection);

  String getPackageId({bool isFullValue = true});

  void init(String id);
}

class PackageControllerImpl implements PackageController {
  final AuthRepository authRepository;

  PackageControllerImpl({
    required this.authRepository,
  });

  late String packageId;

  final _getPackageStateSubject = BehaviorSubject<GetPackageState>.seeded(
    const GetPackageLoadingState(),
  );

  @override
  Stream<GetPackageState> get getPackageStateStream =>
      _getPackageStateSubject.stream.distinct();

  @override
  Future<void> init(String id) async {
    packageId = id;
    await loadPackage();
  }

  void onChangeGetPackageState(GetPackageState newState) {
    if (!_getPackageStateSubject.isClosed) {
      _getPackageStateSubject.add(newState);
    }
  }

  Future<void> loadPackage() async {
    onChangeGetPackageState(const GetPackageLoadingState());

    try {
      final package = await authRepository.getPackage(packageId: packageId);

      onChangeGetPackageState(GetPackageSuccessState(
        package: package,
      ));
    } on ApiClientError catch (e) {
      onChangeGetPackageState(GetPackageErrorState(
        message: e.message ?? '',
      ));
    }
  }

  @override
  String getPackageId({bool isFullValue = true}) {
    if (isFullValue) {
      return packageId;
    }

    return Strings.boxTitle(packageId.substring(0, 8));
  }

  @override
  void navigateToBoxSectionScreen(PackageEditSection packageEditSection) {
    late final int initialTabIndex;

    switch (packageEditSection) {
      case PackageEditSection.shippingFee:
        initialTabIndex = 0;
        break;
      case PackageEditSection.checkPayment:
        initialTabIndex = 1;
        break;
      case PackageEditSection.trackingCode:
        initialTabIndex = 2;
        break;
    }

    Modular.to.navigate(
      RoutesName.boxSections.name,
      arguments: initialTabIndex,
    );
  }

  @override
  void dispose() {
    _getPackageStateSubject.close();
  }
}
