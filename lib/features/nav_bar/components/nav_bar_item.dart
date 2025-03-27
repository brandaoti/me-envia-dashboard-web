import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/values/values.dart';

class NaveBarItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final String iconPath;
  final VoidCallback onPressed;

  const NaveBarItem({
    Key? key,
    required this.title,
    required this.iconPath,
    this.isActive = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: SizedBox(
          child: Row(
            children: [
              _dotte(),
              const HorizontalSpacing(
                width: 58,
              ),
              _body(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            color: isActive ? AppColors.whiteDefault : AppColors.grey300,
          ),
          const HorizontalSpacing(
            width: 8,
          ),
          AutoSizeText(
            title,
            style: TextStyles.navBarItem.copyWith(
              color: isActive ? null : AppColors.grey300,
            ),
          )
        ],
      ),
    );
  }

  Widget _dotte() {
    const decoration = Decorations.navBarItem;
    return AnimatedContainer(
      width: 8,
      height: 40,
      duration: Durations.transition,
      decoration: isActive ? decoration : null,
    );
  }
}
