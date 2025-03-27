import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

class CardGeneralInformationFaq extends StatelessWidget {
  final List<Faq> faqs;
  final VoidCallback onCreateNewFaq;
  final ValueChanged<Faq> onEditFaq;
  final ValueChanged<String> onRemoveFaq;

  const CardGeneralInformationFaq({
    Key? key,
    required this.faqs,
    required this.onCreateNewFaq,
    required this.onEditFaq,
    required this.onRemoveFaq,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _content(context),
      padding: Paddings.allDefault,
      decoration: Decorations.cardOrderItem(false),
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(),
        const VerticalSpacing(
          height: 24,
        ),
        Expanded(
          child: _listOfFaqsItems(context),
        ),
      ],
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: AutoSizeText(
            Strings.faqTitle,
            style: TextStyles.totalDeclared,
          ),
        ),
        Expanded(
          child: _createNewFaqBtn(),
        ),
      ],
    );
  }

  Widget _listOfFaqsItems(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: faqs.map(_faqListItem).toList(),
      ),
    );
  }

  Widget _faqListItem(Faq faq) {
    return Padding(
      padding: Paddings.onlyBottom,
      child: Container(
        width: double.infinity,
        child: _faqItemContent(faq),
        padding: Paddings.allDefaultSmall,
        decoration: Decorations.cardOrderItem(
          false,
          borderRadius: 10,
          color: AppColors.secondary,
        ),
      ),
    );
  }

  Widget _faqItemContent(Faq faq) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: AutoSizeText(
            faq.question,
            textAlign: TextAlign.start,
            style: TextStyles.cardModalItemSubtitle.copyWith(
              fontSize: 16,
              color: AppColors.whiteText,
            ),
          ),
        ),
        const HorizontalSpacing(
          width: 8.0,
        ),
        _editFaqBtn(faq),
        const HorizontalSpacing(
          width: 8.0,
        ),
        _removeFaqBtn(faq.id),
      ],
    );
  }

  Widget _createNewFaqBtn() {
    return DefaultButton(
      radius: 8.0,
      height: 50,
      isValid: true,
      title: Strings.createNewFaqTitleBtn,
      onPressed: onCreateNewFaq,
    );
  }

  Widget _editFaqBtn(Faq faq) {
    return IconButton(
      onPressed: () => onEditFaq(faq),
      padding: EdgeInsets.zero,
      icon: const Icon(MdiIcons.pencil, color: AppColors.whiteDefault),
    );
  }

  Widget _removeFaqBtn(String faqId) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: () => onRemoveFaq(faqId),
      icon: const Icon(MdiIcons.delete, color: AppColors.whiteDefault),
    );
  }
}
