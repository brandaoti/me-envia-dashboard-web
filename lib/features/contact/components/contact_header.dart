import 'package:flutter/material.dart';

import '../../../core/core.dart';

class ContactHeader extends StatelessWidget implements PreferredSizeWidget {
  const ContactHeader({Key? key}) : super(key: key);

  @override
  Size get preferredSize => Sizes.maxHeightContactHeaderSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _body(),
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      padding: Paddings.contactHeader,
      decoration: Decorations.contactHeader,
    );
  }

  Widget _body() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _logo(),
        _enterInContactButton(),
      ],
    );
  }

  Widget _logo() {
    return Image.asset(
      Images.logo,
      width: 185,
      height: 60,
    );
  }

  Widget _enterInContactButton() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 40, maxWidth: 180),
      child: RoundedButton(
        isValid: true,
        title: Strings.enterInContact,
        onPressed: () => Helper.launchTo(Strings.whatsAppContact),
      ),
    );
  }
}
