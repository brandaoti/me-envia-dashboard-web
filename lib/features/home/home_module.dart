import 'package:flutter_modular/flutter_modular.dart';

import '../../features/features.dart';
import '../../core/core.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds {
    return [
      Bind.factory<HomeController>(
        (i) => HomeControllerImpl(
          repository: i(),
        ),
      ),
      Bind.factory<GeneralInformationController>(
        (i) => GeneralInformationControllerImpl(
          authRepository: i(),
        ),
      ),
      Bind.factory<SectionEditController>(
        (i) => SectionEditControllerImpl(
          repository: i(),
          service: i(),
        ),
      ),
      Bind.factory<PackageController>(
        (i) => PackageControllerImpl(
          authRepository: i(),
        ),
      ),
      Bind.factory<TrackingCodeController>(
        (i) => TrackingCodeControllerImpl(
          repository: i(),
        ),
      ),
      Bind.factory<CkeckPaymentController>(
        (i) => CkeckPaymentControllerImpl(
          service: i(),
          repository: i(),
        ),
      ),
      Bind.factory<TotalItemsController>(
        (i) => TotalItemsControllerImpl(
          repository: i(),
        ),
      ),
      Bind.factory<BoxSectionController>(
        (i) => BoxSectionControllerImpl(
          repository: i(),
        ),
      ),
      Bind.factory<ShippingFeeController>(
        (i) => ShippingFeeControllerImpl(
          repository: i(),
        ),
      ),
      Bind.factory<PackageController>(
        (i) => PackageControllerImpl(
          authRepository: i(),
        ),
      ),
      Bind.factory<TrackingCodeController>(
        (i) => TrackingCodeControllerImpl(
          repository: i(),
        ),
      ),
      Bind.factory<MariaTipsController>(
        (i) => MariaTipsControllerImpl(
          repository: i(),
        ),
      ),
      Bind.factory<CreateNewTipsController>(
        (i) => CreateNewTipsControllerImpl(
          service: i(),
          repository: i(),
        ),
      ),
      Bind.factory<CreateItemsController>(
        (i) => CreateItemsControllerImpl(
          repository: i(),
        ),
      ),
      Bind.factory<AddNewItemController>(
        (i) => AddNewItemControllerImpl(
          service: i(),
          repository: i(),
        ),
      ),
    ];
  }

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        RoutesName.initial.name,
        child: (_, args) => const HomeScreen(),
        transition: TransitionType.custom,
        customTransition: AppModule.defaultTransition,
      ),
      ChildRoute(
        RoutesName.boxSections.name,
        child: (_, args) => const BoxSectionScreen(),
        transition: TransitionType.custom,
        customTransition: AppModule.defaultTransition,
      ),
      ChildRoute(
        RoutesName.packageDetail.name,
        child: (_, args) => PackageScreenDetail(
          packageID: args.params['id'],
          packageEditSection: args.data as PackageEditSection,
        ),
        transition: TransitionType.custom,
        customTransition: AppModule.defaultTransition,
      ),
      ChildRoute(
        RoutesName.generalInformation.name,
        child: (_, args) => const GeneralInformationScreen(),
        transition: TransitionType.custom,
        customTransition: AppModule.defaultTransition,
      ),
      ChildRoute(
        RoutesName.mariaTips.name,
        child: (_, args) => const MariaTipsScreen(),
        transition: TransitionType.custom,
        customTransition: AppModule.defaultTransition,
      ),
      ChildRoute(
        RoutesName.listCustomesItems.name,
        child: (_, args) => CustomersItems(
          customers: args.data as Customers,
        ),
        transition: TransitionType.custom,
        customTransition: AppModule.defaultTransition,
      ),
    ];
  }
}
