import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../features.dart';

typedef OnValidateField = bool Function();

class PackageScreenDetail extends StatefulWidget {
  final String packageID;
  final PackageEditSection packageEditSection;

  const PackageScreenDetail({
    Key? key,
    required this.packageID,
    required this.packageEditSection,
  }) : super(key: key);

  @override
  _PackageScreenDetailState createState() => _PackageScreenDetailState();
}

class _PackageScreenDetailState
    extends ModularState<PackageScreenDetail, PackageController> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    controller.init(widget.packageID);
    super.initState();
  }

  bool _isValidateFields() {
    return _formKey.currentState?.validate() ?? false;
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
      body: BodyContentScreen(
        child: _body(),
        padding: Paddings.contentBodyOnlyTop(bottom: 0),
      ),
    );
  }

  Widget _body() {
    return StreamBuilder<GetPackageState>(
      stream: controller.getPackageStateStream,
      builder: (context, snapshot) {
        final state = snapshot.data;

        if (state is GetPackageLoadingState) {
          return const Center(
            child: Loading(),
          );
        }

        if (state is GetPackageErrorState) {
          return _errorState(message: state.message);
        }

        if (state is GetPackageSuccessState) {
          return _content(state.package);
        }

        return Container();
      },
    );
  }

  Widget _errorState({String? message}) {
    return Center(
      child: ErrorState(
        isButtonVisibility: true,
        height: null,
        message: message ?? '',
        textAlign: TextAlign.center,
        padding: Paddings.horizontal,
        onPressed: () => controller.init(widget.packageID),
      ),
    );
  }

  Widget _content(CustomersPackage package) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _contentHeader(),
          _contentSections(package),
        ],
      ),
    );
  }

  Widget _contentHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _subtitle(),
        SectionTitle(
          fontSize: 28,
          title: controller.getPackageId(isFullValue: false),
        ),
        _subtitle(isFirtsText: true),
        const VerticalSpacing(
          height: 24,
        ),
      ],
    );
  }

  Widget _subtitle({bool isFirtsText = false}) {
    return AutoSizeText(
      isFirtsText ? Strings.sectionSubtitle2 : Strings.sectionSubtitle,
      textAlign: TextAlign.start,
      style: TextStyles.sectionTitleStyle.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: isFirtsText ? 16 : 12,
        color: isFirtsText ? AppColors.secondaryTextLight : AppColors.secondary,
      ),
    );
  }

  Widget _contentSections(CustomersPackage package) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 6,
          child: _leftSide(package),
        ),
        const HorizontalSpacing(
          width: 16,
        ),
        Flexible(
          flex: 4,
          child: _rigthSide(package),
        )
      ],
    );
  }

  Widget _leftSide(CustomersPackage package) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const VerticalSpacing(
          height: 24,
        ),
        SectionUserInformation(
          user: package.user,
          package: package.packageInfo,
        ),
        const VerticalSpacing(
          height: 68,
        ),
        _lisOfBoxItens(package.packageItem),
      ],
    );
  }

  Widget _lisOfBoxItens(BoxList boxList) {
    if (boxList.isEmpty) {
      return const EmptyBoxIllustration(
        message: Strings.noRegisteredCustomer,
      );
    }

    return ListOfItems(
      list: boxList,
      isVisibleButton: false,
      onCreateNewItem: null,
      onView: _showPreviewImage,
    );
  }

  Widget _rigthSide(CustomersPackage package) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SectionCustomsDeclaration(
            declarations: package.packageInfo.declarationList,
          ),
          const VerticalSpacing(
            height: 16,
          ),
          SectionShippingFee(
            useDefaultTitle: false,
            useDefaultLayout: false,
            onValidate: _isValidateFields,
            packageId: controller.getPackageId(),
            shippingFee: package.packageInfo.shippingFee,
          ),
          const VerticalSpacing(
            height: 16,
          ),
          CheckPayment(
            package: package.packageInfo,
            packageEditSection: widget.packageEditSection,
          ),
          const VerticalSpacing(
            height: 16,
          ),
          SectionTrackingCode(
            useDefaultLayout: false,
            onValidate: _isValidateFields,
            packageId: controller.getPackageId(),
            trackingCode: package.packageInfo.trackingCode,
            packageEditSection: widget.packageEditSection,
          ),
          const VerticalSpacing(
            height: 24,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }
}
