import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class TextStyles {
  static const TextStyle cardModalItemSubtitle = TextStyle(
    fontSize: 12,
    height: 1.4,
    color: AppColors.secondary,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle boxModalLimitNotificationTitle =
      cardModalItemTitle.copyWith(
    fontWeight: FontWeight.w800,
    color: AppColors.secondary,
  );
  static const TextStyle cardModalItemTitle = TextStyle(
    height: 1.5,
    fontSize: 24,
    color: AppColors.secondary,
    fontWeight: FontWeight.w900,
  );

  static const TextStyle orderHeaderTabBar = TextStyle(
    fontSize: 18,
    color: AppColors.whiteText,
    fontWeight: FontWeight.w900,
  );

  static final TextStyle boxModalLimitNotificationSub =
      cardModalItemSubtitle.copyWith(
    height: 1.5,
    color: AppColors.secondary,
  );

  static const TextStyle labelStyle = TextStyle(
    fontSize: 16.0,
    color: AppColors.grey500,
    fontWeight: FontWeight.w400,
  );

  // Box Bottom Sheet and Confirm order
  static final TextStyle boxModalLimitTitle = stockAddressTitleStyle.copyWith(
    fontWeight: FontWeight.w800,
  );
  static const TextStyle stockAddressTitleStyle = TextStyle(
    color: AppColors.secondary,
    fontSize: 28,
    fontWeight: FontWeight.w900,
    height: 1.2,
  );

  static final TextStyle inputTextStyle = labelStyle.copyWith(
    color: AppColors.black,
  );

  static const TextStyle tipsTitleStyle = TextStyle(
    fontSize: 38,
    color: AppColors.secondary,
    fontWeight: FontWeight.w900,
  );

  static const TextStyle tipsSubtitle = TextStyle(
    fontSize: 20,
    color: AppColors.secondary,
    fontWeight: FontWeight.normal,
  );

// Buttons TextStyles
  static TextStyle defaultButton(bool isValid) => TextStyle(
        fontSize: 18,
        color: isValid ? AppColors.white : AppColors.grey400,
        fontWeight: FontWeight.w500,
      );

  static TextStyle bordlessButton(bool isValid) => TextStyle(
        color: isValid ? AppColors.primary : AppColors.grey400,
        fontSize: 18,
      );

  static TextStyle roundedButton(bool isValid) => TextStyle(
        color: isValid ? AppColors.primary : AppColors.grey400,
        fontSize: 18,
      );

  static const TextStyle skipButton = TextStyle(
    color: AppColors.grey500,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  //forgotPassWord TextStyles
  static const TextStyle forgotPasswordTitles = TextStyle(
    fontSize: 28,
    color: AppColors.black,
    fontWeight: FontWeight.w900,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle forgotPasswordContent = TextStyle(
    height: 1.4,
    fontSize: 21.0,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle expansionTileContentStyle = TextStyle(
    height: 1.45,
    fontSize: 16,
    color: AppColors.secondary,
    fontWeight: FontWeight.w500,
  );

  // Resgitration
  static const TextStyle resgitrationHeaderTitle = TextStyle(
    fontSize: 38,
    color: AppColors.secondary,
    fontWeight: FontWeight.w900,
  );

  static const TextStyle resgitrationAccepTermOfUse = TextStyle(
    fontSize: 14,
    color: AppColors.secondary,
    fontWeight: FontWeight.w500,
  );

  // Home
  static const TextStyle homeHeaderTitle = TextStyle(
    fontSize: 28,
    color: AppColors.primary,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle homeHeaderSubtitle = TextStyle(
    fontSize: 12,
    letterSpacing: 0.4,
    color: AppColors.blackText,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle navBarItem = TextStyle(
    fontSize: 18,
    letterSpacing: 0.4,
    color: AppColors.whiteText,
    fontWeight: FontWeight.w400,
  );
  //requested Box

  static const TextStyle requestedBoxTitle = TextStyle(
    fontSize: 28,
    color: AppColors.secondary,
    fontWeight: FontWeight.w900,
  );

  static const TextStyle requestedBoxSubtitle = TextStyle(
    color: AppColors.secondaryTextLight,
  );

  static const TextStyle tableTitles = TextStyle(
    fontWeight: FontWeight.w800,
    color: AppColors.secondary,
  );

  //No Connection
  static const TextStyle noConnectionTitle = TextStyle(
    height: 1.4,
    fontSize: 28,
    color: AppColors.black,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle noConnectionSubtitle = TextStyle(
    color: AppColors.black,
    height: 1.4,
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  // Section User information component
  static const TextStyle userInformation = TextStyle(
    height: 1.5,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryTextLight,
  );

  static const TextStyle sectionUserTitleStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.secondaryTextLight,
  );

  static const TextStyle userNameStyle = TextStyle(
    fontSize: 24,
    color: AppColors.secondary,
    fontWeight: FontWeight.w900,
  );

  // ! Section title style
  static const TextStyle sectionHeaderTitleStyle = TextStyle(
    fontSize: 28,
    color: AppColors.secondary,
    fontWeight: FontWeight.w900,
  );

  static const sectionTitleStyle = TextStyle(
    fontSize: 18,
    color: AppColors.grey500,
    fontWeight: FontWeight.w600,
  );

  // Section Package item component
  static const TextStyle orderHeaderPhotoAttached = TextStyle(
    fontSize: 14,
    color: AppColors.secondary,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle orderBoxProduct = orderHeaderPhotoAttached.copyWith(
    height: 1.4,
    fontSize: 18,
    fontWeight: FontWeight.w800,
  );

  static final TextStyle packageItemsStyle = userNameStyle.copyWith(
    color: AppColors.grey500,
  );

  // Section Customs Declaration
  static const TextStyle cardDeclarationItemTitle = TextStyle(
    height: 1.6,
    fontSize: 18,
    color: AppColors.secondary,
    fontWeight: FontWeight.w800,
  );

  //Maria tips
  static const TextStyle mariaTipsTitle = TextStyle(
    height: 1.4,
    fontSize: 38,
    color: AppColors.secondary,
    fontWeight: FontWeight.w900,
  );

  static final TextStyle mariaTipsCardDate = mariaTipsTitle.copyWith(
    fontSize: 12,
    color: AppColors.grey500,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle cardDeclarationItemSubtitle = userInformation.copyWith(
    color: AppColors.secondaryLight,
  );

  static const TextStyle createNewItemsFile = TextStyle(
    height: 1.6,
    fontSize: 18,
    color: AppColors.secondary,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle totalDeclared = orderHeaderPhotoAttached.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static TextStyle paymenteStatus(bool isPending) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: isPending ? AppColors.alertRedColor : AppColors.alertBlueColor,
      );

  // Section Delivery
  static const TextStyle objectNotificationStyle = TextStyle(
    color: AppColors.secondary,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle textLocationStyle = TextStyle(
    color: AppColors.secondaryLight,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
  static const TextStyle boxTitleStyle = TextStyle(
    color: AppColors.secondary,
    fontSize: 18,
    fontWeight: FontWeight.w900,
    height: 1.3,
  );
  static const TextStyle boxCountStyle = TextStyle(
    fontSize: 12,
    color: AppColors.secondary,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle toMonthAbbreStrStyle = TextStyle(
    fontSize: 12,
    color: AppColors.secondary,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle toHourAbbreStrStyle = TextStyle(
    fontSize: 12,
    color: AppColors.grey400,
    fontWeight: FontWeight.w400,
  );

  // Dollar Quotation
  static TextStyle dollarQuotation(bool isMoney) => TextStyle(
        height: 1.2,
        letterSpacing: 0.6,
        fontSize: isMoney ? 16 : 12,
        fontWeight: FontWeight.w600,
        color: isMoney ? AppColors.black : AppColors.grey500,
      );

  static const TextStyle dollarQuotationModalTitle = TextStyle(
    height: 1.2,
    fontSize: 24,
    letterSpacing: 0.8,
    color: AppColors.secondary,
    fontWeight: FontWeight.w600,
  );

  // General information
  static const TextStyle cardInformationTitle = TextStyle(
    fontSize: 20,
    color: AppColors.secondary,
    fontWeight: FontWeight.w600,
  );

  static TextStyle cardInformationSubtitle = toMonthAbbreStrStyle.copyWith(
    fontSize: 18,
    color: AppColors.black,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle modalEditingCompletedStyle = TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w800,
  );

  // Customers detail
  static const TextStyle customersHeaderSubtitle = TextStyle(
    fontSize: 21,
    color: AppColors.grey500,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
  );

  static TextStyle checkPayment({
    Color primary = AppColors.grey400,
  }) =>
      TextStyle(
        height: 1.4,
        fontSize: 18,
        color: primary,
        fontWeight: FontWeight.normal,
      );

  static const TextStyle contactTitle = TextStyle(
    fontSize: 72,
    fontWeight: FontWeight.w100,
    color: AppColors.whiteDefault,
  );

  static const TextStyle contactSubtitle = TextStyle(
    height: 1.4,
    fontSize: 24,
    letterSpacing: 2,
    fontWeight: FontWeight.w400,
    color: AppColors.whiteDefault,
  );

  static const TextStyle contactAddress = TextStyle(
    height: 1.2,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.whiteDefault,
  );

  static const TextStyle talkToMeTitle = TextStyle(
    height: 1.6,
    fontSize: 32,
    letterSpacing: 1.6,
    color: AppColors.grey500,
    fontWeight: FontWeight.w600,
  );
}
