import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../contact_controller.dart';
import 'contact_location.dart';
import 'talk_to_me_form.dart';

class TalkToMe extends StatelessWidget {
  final ContactController controller;

  const TalkToMe({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _body(),
      width: double.infinity,
      color: AppColors.grey100,
      padding: Paddings.contactTalkToMe,
    );
  }

  Widget _body() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: _content(
            title: Strings.talkToMe,
            child: TalkToMeForm(
              controller: controller,
            ),
          ),
        ),
        const Spacer(flex: 2),
        Expanded(
          flex: 3,
          child: _content(
            title: Strings.location,
            child: const ContactLocation(),
          ),
        ),
      ],
    );
  }

  Widget _content({
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const VerticalSpacing(
          height: 24,
        ),
        AutoSizeText(
          title,
          style: TextStyles.talkToMeTitle,
        ),
        const VerticalSpacing(
          height: 16,
        ),
        child,
      ],
    );
  }
}
