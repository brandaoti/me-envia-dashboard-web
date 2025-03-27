import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class Decorations {
  static final inputBorderForms = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: AppColors.secondary),
  );

  static const Decoration orderHeaderTabBar = UnderlineTabIndicator(
    borderSide: BorderSide(width: 8, color: AppColors.primary),
  );

  static final inputBorderFormFocused = inputBorderForms.copyWith(
    borderSide: const BorderSide(color: AppColors.black),
  );
  static const RoundedRectangleBorder dialogs = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(20),
    ),
  );

  static BoxDecoration stepsDecoration(bool isActive) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: isActive ? AppColors.primary : AppColors.grey300,
    );
  }

  static const BoxDecoration navBar = BoxDecoration(
    color: AppColors.secondary,
    borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
  );

  static const BoxDecoration navBarItem = BoxDecoration(
    color: AppColors.primary,
    borderRadius: BorderRadius.horizontal(
      right: Radius.circular(8),
    ),
  );

  static BoxDecoration customTabBar = BoxDecoration(
    border: Border(
      bottom: BorderSide(
        width: 3,
        color: AppColors.secondaryLight.withOpacity(.2),
      ),
    ),
  );

  static BoxDecoration paginateItems(bool isActive, [Color? color]) =>
      BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? color ?? AppColors.primary : AppColors.whiteDefault,
      );

  //Maria Tips
  static BoxDecoration cardTipsDecoration({bool useBlur = false}) =>
      BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        gradient: useBlur
            ? LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  AppColors.grey400.withOpacity(0),
                  AppColors.secondary.withOpacity(0.8),
                ],
                end: Alignment.bottomCenter,
              )
            : null,
      );

  static BoxDecoration cardOrderItem(
    bool isSelected, {
    double borderRadius = 20,
    double borderWidth = 2,
    Color color = AppColors.grey100,
  }) =>
      BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: const [
          BoxShadow(
            blurRadius: 13,
            offset: Offset(0, 4),
            color: Color.fromRGBO(0, 0, 0, 0.05),
          ),
        ],
        border: isSelected
            ? Border.all(color: AppColors.alertGreenColor, width: borderWidth)
            : null,
      );

  static BoxDecoration packageItemCount = navBarItem.copyWith(
    borderRadius: BorderRadius.circular(20),
  );

  static BoxDecoration homeHeaderDate = BoxDecoration(
    color: AppColors.whiteText,
    borderRadius: BorderRadius.circular(50),
  );

  static BoxDecoration customsDeclarationItem = BoxDecoration(
    color: AppColors.grey400,
    borderRadius: BorderRadius.circular(20),
  );

  static OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(
      color: AppColors.alertGreenColor,
    ),
  );

  static BoxDecoration paymenteStatus(bool isPending) => BoxDecoration(
        color: isPending
            ? AppColors.alertRedColor.withOpacity(.2)
            : AppColors.alertBlueColor.withOpacity(.2),
        borderRadius: BorderRadius.circular(20),
      );

  static final BoxDecoration dollarQuotation = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: AppColors.alertGreenColor.withOpacity(0.1),
    border: Border.all(color: AppColors.alertGreenColor),
  );

  static BoxDecoration dollarQuotationModal = BoxDecoration(
    color: AppColors.whiteDefault,
    boxShadow: [
      BoxShadow(
        blurRadius: 13,
        offset: const Offset(0, 4),
        color: AppColors.black.withOpacity(0.2),
      )
    ],
    borderRadius: BorderRadius.circular(20),
  );

  static BoxDecoration dollarQuotationCheck = const BoxDecoration(
    shape: BoxShape.circle,
    color: AppColors.alertGreenColor,
  );

  static RoundedRectangleBorder allModalBorderRadius({
    double borderRadius = 20,
  }) =>
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      );

  static BoxDecoration checkPayment({
    Color primary = AppColors.grey400,
  }) =>
      BoxDecoration(
        border: Border.all(color: primary),
        borderRadius: BorderRadius.circular(20),
      );

  static BoxDecoration contactHeader = const BoxDecoration(
    color: AppColors.whiteDefault,
    boxShadow: [
      BoxShadow(
        blurRadius: 4,
        offset: Offset(2, 8),
        color: Color.fromRGBO(141, 127, 127, 0.25),
      ),
    ],
  );
}
