import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/core.dart';

import '../components/customs_declaration_item.dart';
import '../components/section_title_texts.dart';

class SectionCustomsDeclaration extends StatelessWidget {
  final DeclarationList declarations;

  const SectionCustomsDeclaration({
    Key? key,
    required this.declarations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          fontSize: 24,
          color: AppColors.grey500,
          title: Strings.sectionCustomsDeclarationTitle,
        ),
        const VerticalSpacing(
          height: 8,
        ),
        _listOfDeclarationItems(),
      ],
    );
  }

  Widget _title() {
    return AutoSizeText(
      Strings.boxNoItemRegisteredTitle,
      style: TextStyles.sectionTitleStyle.copyWith(
        height: 1.4,
        fontSize: 12,
        color: AppColors.grey500,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _listOfDeclarationItems() {
    if (declarations.isEmpty) {
      return _illustration();
    }

    List<Widget> children = [];

    for (int index = 0; index < declarations.length; index++) {
      children.add(_itemDeclaration(
        index: index,
        declaration: declarations[index],
      ));
    }

    return Column(
      children: children,
      mainAxisAlignment: MainAxisAlignment.start,
    );
  }

  Widget _itemDeclaration({
    required Declaration declaration,
    required int index,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: CustomsDeclarationItem(declaration: declaration, index: index + 1),
    );
  }

  Widget _illustration() {
    return Container(
      child: _picture(),
      padding: Paddings.allDefaultSmall,
      constraints: const BoxConstraints(
        maxWidth: double.infinity,
      ),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }

  Widget _picture() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Svgs.logoNoItemRegistered,
          ),
          const VerticalSpacing(
            height: 16.0,
          ),
          _title(),
        ],
      ),
    );
  }
}
