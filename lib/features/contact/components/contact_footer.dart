import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/core.dart';

class ContactFooter extends StatelessWidget {
  const ContactFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _body(),
      width: double.infinity,
      color: AppColors.secondary,
      padding: Paddings.contactFooter,
    );
  }

  Widget _body() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _leftSide(),
            _rifgthSie(),
          ],
        ),
        const VerticalSpacing(
          height: 60,
        ),
        _copyright(),
      ],
    );
  }

  Widget _leftSide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _profile(),
        const VerticalSpacing(
          height: 24,
        ),
        _addressApplication(),
        const VerticalSpacing(
          height: 16,
        ),
        _addressApplication(isPhone: false),
      ],
    );
  }

  Widget _profile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(Images.maria),
            ),
            border: Border.all(color: AppColors.grey300, width: 2),
          ),
          width: Dimens.maxHeightContactHeaderSize,
          height: Dimens.maxHeightContactHeaderSize,
        ),
        const HorizontalSpacing(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              Strings.maryHelena,
              style: TextStyles.talkToMeTitle.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.whiteDefault,
              ),
            ),
            AutoSizeText(
              Strings.maryHelenaDescription,
              style: TextStyles.talkToMeTitle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.whiteDefault,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _addressApplication({bool isPhone = true}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          isPhone ? Icons.phone_android_rounded : Icons.location_on_rounded,
          size: 28,
          color: AppColors.whiteDefault,
        ),
        const HorizontalSpacing(
          width: 8,
        ),
        Visibility(
          visible: !isPhone,
          replacement: const AutoSizeText(
            Strings.phoneAddress,
            style: TextStyles.contactAddress,
          ),
          child: AutoSizeText.rich(
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
          ),
        ),
      ],
    );
  }

  Widget _rifgthSie() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            _socialMedia(
              source: Svgs.whatsApp,
              onPressed: () => Helper.launchTo(Strings.whatsAppContact),
            ),
            const HorizontalSpacing(
              width: 20,
            ),
            _socialMedia(
              source: Svgs.instragram,
              onPressed: () => Helper.launchTo(Strings.socialMediaLinks.first),
            ),
            const HorizontalSpacing(
              width: 20,
            ),
            _socialMedia(
              source: Svgs.telegram,
              onPressed: () => Helper.launchTo(Strings.socialMediaLinks.last),
            ),
          ],
        ),
        const VerticalSpacing(
          height: 60,
        ),
        Row(
          children: [
            _storeApplication(
              source: Images.google,
              onPressed: () => Helper.launchTo(Strings.storeLinksApp.first),
            ),
            const HorizontalSpacing(
              width: 20,
            ),
            _storeApplication(
              source: Images.apple,
              onPressed: () => Helper.launchTo(Strings.storeLinksApp.last),
            ),
          ],
        )
      ],
    );
  }

  Widget _socialMedia({
    required String source,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        child: SvgPicture.asset(source),
        width: Dimens.cardSendBoxHeight,
        height: Dimens.cardSendBoxHeight,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _storeApplication({
    required String source,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 180,
      height: 60,
      child: InkWell(
        onTap: onPressed,
        child: Image.asset(source),
      ),
    );
  }

  Widget _copyright() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: AutoSizeText(
        Strings.copyright,
        style: TextStyles.talkToMeTitle.copyWith(
          fontSize: 14,
          color: AppColors.grey300,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
