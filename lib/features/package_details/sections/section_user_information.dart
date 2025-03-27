import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../core/helpers/extensions.dart';
import '../../../core/models/models.dart';
import '../../../core/values/values.dart';
import 'section_delivery.dart';

class SectionUserInformation extends StatelessWidget {
  final User user;
  final Package package;

  const SectionUserInformation({
    Key? key,
    required this.user,
    required this.package,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: _leftSide(),
        ),
        const HorizontalSpacing(
          width: 16,
        ),
        Expanded(
          child: _rigthSide(),
        )
      ],
    );
  }

  Widget _content({required Widget child}) {
    return Container(
      child: child,
      padding: Paddings.allDefaultSmall,
      decoration: Decorations.cardOrderItem(false),
      constraints: const BoxConstraints(minHeight: 200),
    );
  }

  Widget _leftSide() {
    return _content(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _text(
            title: user.name,
            style: TextStyles.userNameStyle,
          ),
          const VerticalSpacing(
            height: 8,
          ),
          _contentSection()
        ],
      ),
    );
  }

  Widget _rigthSide() {
    return _content(
      child: SectionDelivery(
        package: package,
      ),
    );
  }

  Widget _contentSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: _generalData(),
        ),
        const HorizontalSpacing(
          width: 12,
        ),
        Expanded(
          flex: 2,
          child: _address(),
        ),
      ],
    );
  }

  Widget _generalData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _text(
          title: Strings.sectionUserTypeLabel.first,
          style: TextStyles.sectionUserTitleStyle,
        ),
        _text(
          title: Strings.sectionUserEmail(user.email),
        ),
        _text(
          title: user.getCpfWithMaks,
        ),
        _text(
          title: user.getPhoneWithMaks,
        ),
      ],
    );
  }

  Widget _address() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _text(
          title: Strings.sectionUserTypeLabel.last,
          style: TextStyles.sectionUserTitleStyle,
        ),
        _text(
          title: user.getFullLocation,
        ),
        _text(
          title: user.getZipCodeWithMaks,
        ),
        _text(
          title: user.address.complement ?? '',
        ),
      ],
    );
  }

  Widget _text({
    double vertical = 2,
    required String title,
    TextStyle style = TextStyles.userInformation,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: vertical),
      child: AutoSizeText(
        title,
        style: style,
        textAlign: TextAlign.left,
      ),
    );
  }
}
