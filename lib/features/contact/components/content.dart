import 'dart:ui';

import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import 'information_shape.dart';

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: _body(context),
      width: double.infinity,
      height: context.screenHeight - Dimens.maxHeightContactHeaderSize,
    );
  }

  Widget _body(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _background(context),
        _backgroundBluer(context),
        Positioned.fill(child: _information(context))
      ],
    );
  }

  Widget _background(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerRight,
      child: Image.asset(Images.inventory, fit: BoxFit.cover),
      height: context.screenHeight - Dimens.maxHeightContactHeaderSize,
    );
  }

  Widget _backgroundBluer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: ColoredBox(color: Colors.black.withOpacity(0.1)),
      ),
      alignment: Alignment.centerRight,
      height: context.screenHeight - Dimens.maxHeightContactHeaderSize,
    );
  }

  Widget _information(BuildContext context) {
    final maxHeight = context.screenHeight - Dimens.maxHeightContactHeaderSize;

    return Container(
      height: maxHeight,
      width: double.infinity,
      child: CustomPaint(
        painter: InformationShape(),
        child: _informationContent(maxHeight),
      ),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _informationContent(double maxHeight) {
    return Container(
      height: maxHeight,
      width: double.infinity,
      padding: Paddings.contactHeader,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _title(),
          _subtitle(),
          _addressApplication(),
        ],
      ),
    );
  }

  Widget _title() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 340),
      child: AutoSizeText.rich(
        TextSpan(
          text: Strings.contentTitles.first,
          style: TextStyles.contactTitle,
          children: [
            TextSpan(
              text: Strings.contentTitles.last,
              style: TextStyles.contactTitle.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _subtitle() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: const AutoSizeText(
        Strings.contentSubtitle,
        style: TextStyles.contactSubtitle,
      ),
    );
  }

  Widget _addressApplication() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          Strings.contentAddressTitle,
          style: TextStyles.contactSubtitle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
        const VerticalSpacing(
          height: 18,
        ),
        Row(
          children: [
            const Icon(
              Icons.location_on_rounded,
              size: 28,
              color: AppColors.whiteDefault,
            ),
            const HorizontalSpacing(
              width: 8,
            ),
            _addressInformation(),
          ],
        )
      ],
    );
  }

  Widget _addressInformation() {
    return AutoSizeText.rich(
      TextSpan(
        style: TextStyles.contactAddress,
        text: Strings.contentAddressSubtitles.first,
        children: [
          TextSpan(
            text: Strings.contentAddressSubtitles[1],
            style: TextStyles.contactAddress.copyWith(
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: Strings.contentAddressSubtitles.last,
          ),
        ],
      ),
    );
  }
}
