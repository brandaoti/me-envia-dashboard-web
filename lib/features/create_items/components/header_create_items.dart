import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../core/helpers/extensions.dart';
import '../../../core/models/models.dart';
import '../../../core/values/values.dart';

class HeaderCreateItems extends StatelessWidget {
  final User user;

  const HeaderCreateItems({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(),
        const VerticalSpacing(
          height: 13,
        ),
        _informations(),
      ],
    );
  }

  Widget _title() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: AutoSizeText(
        Strings.generalInformations,
        style: TextStyles.customersHeaderSubtitle,
      ),
    );
  }

  Widget _informations() {
    return Container(
      width: double.infinity,
      child: _informationItem(),
      padding: Paddings.allDefaultSmall,
      decoration: Decorations.cardOrderItem(false),
      constraints: const BoxConstraints(maxHeight: 380),
    );
  }

  Widget _informationItem() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _informationItemtext(
          vertical: 0,
          text: Strings.sectionUserTypeLabel.first,
          style: TextStyles.sectionUserTitleStyle,
        ),
        _informationItemtext(
          text: Strings.sectionUserEmail(user.email),
        ),
        _informationItemtext(
          text: user.getCpfWithMaks,
        ),
        _informationItemtext(
          text: user.getPhoneWithMaks,
        ),
        const VerticalSpacing(
          height: 30,
        ),
        _informationItemtext(
          vertical: 0,
          text: Strings.sectionUserTypeLabel.last,
          style: TextStyles.sectionUserTitleStyle,
        ),
        _informationItemtext(
          text: user.getFullLocation,
        ),
        _informationItemtext(
          text: user.getZipCodeWithMaks,
        ),
        _informationItemtext(
          text: user.address.neighborhood,
        ),
        _informationItemtext(
          text: user.address.complement ?? '',
        ),
      ],
    );
  }

  Widget _informationItemtext({
    TextStyle? style,
    required String text,
    double vertical = 1.5,
  }) {
    const defaultSyle = TextStyles.userInformation;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: vertical),
      child: AutoSizeText(
        text,
        textAlign: TextAlign.left,
        style: style ?? defaultSyle,
      ),
    );
  }
}
