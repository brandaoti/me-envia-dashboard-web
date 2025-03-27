import 'package:flutter/material.dart';

import '../core.dart';
import 'dimens.dart';

abstract class Sizes {
  static const Size orderHeaderStandardHeight = Size.fromHeight(
    Dimens.orderHeaderStandardHeight,
  );

  static const BoxConstraints countItems = BoxConstraints(
    minWidth: 60,
    minHeight: 24,
  );

  static const BoxConstraints paginate = BoxConstraints(
    maxWidth: 330,
    maxHeight: 32,
  );

  static const BoxConstraints addItemButton = BoxConstraints(
    maxHeight: 40,
    maxWidth: 140,
  );

  static const BoxConstraints homeReportPayments = BoxConstraints(
    minHeight: 180,
    minWidth: double.infinity,
  );

  static const Size dollarQuote = Size(152, 60);
  static const Size dollarQuoteModal = Size(640, Dimens.maxWidth);

  static const BoxConstraints loginForms = BoxConstraints(
    maxWidth: Dimens.maxWidth,
    maxHeight: 598,
  );

  static const BoxConstraints registrationForms = BoxConstraints(
    maxWidth: Dimens.maxWidth,
    maxHeight: Dimens.maxHeightForms,
  );

  static const Size homeHeaderHeight = Size.fromHeight(Dimens.homeHeaderHeight);

  static BoxConstraints modalMaxWidth([double maxHeight = double.infinity]) =>
      BoxConstraints(
        maxHeight: maxHeight,
        maxWidth: Dimens.modalMaxWidth,
      );

  static const BoxConstraints emptyBoxIllustration = BoxConstraints(
    maxHeight: Dimens.navBarMaxWith,
    maxWidth: Dimens.navBarMaxWith,
  );
  static const BoxConstraints boxIllustrationMessage = BoxConstraints(
    maxWidth: 200,
  );

  static const BoxConstraints modalPreviewImageMaxWidgth = BoxConstraints(
    maxWidth: Dimens.modalPreviewImageMaxWidgth,
  );

  static BoxConstraints checkPayment(double maxWidth) =>
      BoxConstraints(maxWidth: maxWidth);

  static Size maxHeightContactHeaderSize =
      const Size.fromHeight(Dimens.maxHeightContactHeaderSize);
}
