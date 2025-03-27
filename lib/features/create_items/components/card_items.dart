import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

class CardItems extends StatelessWidget {
  final Box box;
  final int index;
  final bool isSelected;
  final OrderStatus orderStatus;
  final VoidCallback? onPressed;

  const CardItems({
    Key? key,
    required this.box,
    required this.index,
    this.isSelected = false,
    this.orderStatus = OrderStatus.viewing,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _body(),
      width: double.infinity,
      alignment: Alignment.center,
      padding: Paddings.expansiontion,
      constraints: const BoxConstraints(minHeight: 102),
    );
  }

  Widget _body() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...[
          const HorizontalSpacing(
            width: 12,
          ),
          _profile(),
          const HorizontalSpacing(
            width: 24,
          ),
          Expanded(child: _headerText()),
        ],
        _icon()
      ],
    );
  }

  Widget _headerText() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: AutoSizeText(
            !box.nameIsEmpty ? box.name : Strings.boxItemName(index),
            maxLines: 1,
            minFontSize: 16,
            style: TextStyles.customersHeaderSubtitle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const VerticalSpacing(
          height: 8,
        ),
        _headerSubtitle(),
      ],
    );
  }

  Widget _headerSubtitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(
          Icons.attach_file,
          size: 14,
          color: AppColors.black,
        ),
        const HorizontalSpacing(
          width: 8,
        ),
        AutoSizeText(
          Strings.onePhotoAttached,
          style: TextStyles.orderHeaderPhotoAttached.copyWith(
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _icon() {
    return IconButton(
      icon: const Icon(Icons.open_in_full),
      onPressed: onPressed,
    );
  }

  Widget _profile() {
    const Color color = AppColors.cardOrderDisable;

    Widget child = Container();

    if (!box.imageIsEmpty) {
      child = _profileItem(box.media!, color);
    }

    return Container(
      child: child,
      width: Dimens.orderCardProfileSize,
      height: Dimens.orderCardProfileSize,
      decoration: const BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _profileItem(
    String media,
    Color color,
  ) {
    return CircleAvatar(
      backgroundColor: color,
      child: PlatformImage.element(
        media,
        radius: Dimens.orderCardProfileSize,
      ),
      maxRadius: Dimens.orderCardProfileSize,
      minRadius: Dimens.orderCardProfileSize,
    );
  }
}
