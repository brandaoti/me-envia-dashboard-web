import 'package:flutter/material.dart';

import 'dimens.dart';

abstract class Paddings {
  static const horizontal = EdgeInsets.symmetric(
    horizontal: Dimens.horizontal,
  );

  static const vertical = EdgeInsets.symmetric(
    vertical: Dimens.horizontal,
  );

  static const horizontalSmall = EdgeInsets.symmetric(
    horizontal: Dimens.vertical,
  );
  static const bodyHorizontal = EdgeInsets.symmetric(
    horizontal: Dimens.horizontal24,
  );

  static const zero = EdgeInsets.zero;

  static const inputPaddingForms = EdgeInsets.symmetric(
    vertical: Dimens.vertical,
  );

  static const mariaTipsCardPadding = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 10,
  );
  static const listTilePadding = EdgeInsets.all(Dimens.vertical);

  static const inputContentPadding = EdgeInsets.symmetric(
    vertical: 18,
    horizontal: Dimens.vertical,
  );

  static const allSmall = EdgeInsets.all(8.0);
  static const allDefault = EdgeInsets.all(Dimens.horizontal);
  static const allDefaultSmall = EdgeInsets.all(Dimens.vertical);

  static const onlyBottom = EdgeInsets.only(bottom: Dimens.vertical);

  static const contentPadding =
      EdgeInsets.symmetric(vertical: 20, horizontal: 16);

  static const expansiontion = EdgeInsets.symmetric(vertical: 16);
  static const expansiontionTitle = EdgeInsets.only(left: 8, top: 15);

  static const homeHeader = EdgeInsets.only(
    left: Dimens.horizontal,
    right: Dimens.horizontal,
    top: Dimens.vertical,
  );

  static const homeHeaderDate = EdgeInsets.symmetric(
    horizontal: 8.0,
    vertical: 2,
  );

  static const dialogs = EdgeInsets.all(32);

  static const regsitartionFormFiels = EdgeInsets.only(bottom: 18);
  static const contactFormFiels = EdgeInsets.only(bottom: 28);
  static const contactFormFiels2 =
      EdgeInsets.symmetric(horizontal: 16, vertical: 22);

  static const dollarQuotation = EdgeInsets.symmetric(horizontal: 12);

  static const contentBody = EdgeInsets.symmetric(
    vertical: 50,
    horizontal: 100,
  );

  static const contentBodyOnly = EdgeInsets.only(
    top: 50,
    left: 100,
    bottom: 20,
    right: 100,
  );

  static contentBodyOnlyTop({double bottom = 34}) => EdgeInsets.only(
        top: 50,
        left: 100,
        right: 100,
        bottom: bottom,
      );

  static const modalCreateNewFaq = EdgeInsets.symmetric(
    vertical: 36,
    horizontal: 32,
  );
  static const allDefaultModal = EdgeInsets.all(32);

  static const listOfCustomers = EdgeInsets.symmetric(horizontal: 32);
  static const contactHeader = EdgeInsets.symmetric(
    horizontal: Dimens.contactHeaderHorizontal,
  );

  static const contactTalkToMe = EdgeInsets.only(
      left: Dimens.contactHeaderHorizontal,
      right: Dimens.contactHeaderHorizontal,
      bottom: 67);

  static const contactFooter = EdgeInsets.symmetric(
    vertical: Dimens.horizontal,
    horizontal: Dimens.contactHeaderHorizontal,
  );
}
