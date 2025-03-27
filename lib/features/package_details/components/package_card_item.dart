import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

class PackageCard extends StatefulWidget {
  final Box box;
  final int index;
  final bool isSelected;
  final OrderStatus orderStatus;
  final VoidCallback? onPressed;

  const PackageCard({
    Key? key,
    required this.box,
    required this.index,
    this.isSelected = false,
    this.orderStatus = OrderStatus.viewing,
    this.onPressed,
  }) : super(key: key);

  @override
  _PackageCardState createState() => _PackageCardState();
}

class _PackageCardState extends State<PackageCard>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _iconTurns;
  late final AnimationController _controller;
  bool _isExpanded = false;

  void _onExpansionChanged() {
    _isExpanded = !_isExpanded;
    if (_isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Durations.transition,
      vsync: this,
    );

    _iconTurns = _controller.drive(
      Tween<double>(begin: 0.0, end: 0.5).chain(
        CurveTween(curve: Curves.easeIn),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      focusColor: AppColors.transparent,
      hoverColor: AppColors.transparent,
      child: Container(
        child: _body(),
        width: double.infinity,
        alignment: Alignment.center,
        padding: Paddings.expansiontion,
        height: _isExpanded ? 260 : 102,
        decoration: Decorations.cardOrderItem(widget.isSelected),
      ),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _header(),
        Expanded(
          child: _expandedProfileImage(),
        ),
      ],
    );
  }

  Widget _expandedProfileImage() {
    const double radius = 20;
    Widget child = Container();

    if (!widget.box.imageIsEmpty) {
      child = ImageCachedLoading(
        radius: radius,
        fit: BoxFit.cover,
        imageUrl: widget.box.media,
      );
    }

    return Visibility(
      visible: _isExpanded,
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: AnimatedContainer(
          child: child,
          width: double.infinity,
          height: _isExpanded ? 120 : 0,
          duration: Durations.transition,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    );
  }

  Widget _header() {
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
        _expandedIcon()
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
            !widget.box.nameIsEmpty
                ? widget.box.name
                : Strings.boxItemName(widget.index),
            maxLines: 1,
            minFontSize: 16,
            style: TextStyles.orderBoxProduct,
          ),
        ),
        const VerticalSpacing(
          height: 8,
        ),
        Visibility(
          child: _headerSubtitle(),
          visible: widget.orderStatus == OrderStatus.viewing,
        )
      ],
    );
  }

  Widget _headerSubtitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        Icon(
          Icons.attach_file,
          size: 14,
          color: AppColors.black,
        ),
        HorizontalSpacing(
          width: 8,
        ),
        AutoSizeText(
          Strings.onePhotoAttached,
          style: TextStyles.orderHeaderPhotoAttached,
        ),
      ],
    );
  }

  Widget _expandedIcon() {
    return IconButton(
      hoverColor: AppColors.transparent,
      splashColor: AppColors.transparent,
      highlightColor: AppColors.transparent,
      icon: RotationTransition(
        turns: _iconTurns,
        child: const Icon(Icons.arrow_drop_down),
      ),
      onPressed: () => setState(_onExpansionChanged),
    );
  }

  Widget _profile() {
    const Color color = AppColors.cardOrderDisable;

    Widget child = Container();

    if (!widget.box.imageIsEmpty) {
      child = _profileItem(
        widget.box.media!,
        color,
        widget.isSelected,
      );
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
    bool isSelected,
  ) {
    switch (widget.orderStatus) {
      case OrderStatus.viewing:
        return CircleAvatar(
          backgroundColor: color,
          backgroundImage: NetworkImage(media),
          maxRadius: Dimens.orderCardProfileSize,
          minRadius: Dimens.orderCardProfileSize,
        );
      case OrderStatus.selecting:
        final itemColorMapping = {
          'icon': {
            false: AppColors.grey400,
            true: AppColors.alertGreenColor,
          },
          'background': {
            false: color,
            true: AppColors.alertGreenColorLight,
          }
        };

        return CircleAvatar(
          maxRadius: Dimens.orderCardProfileSize,
          minRadius: Dimens.orderCardProfileSize,
          child: Icon(
            Icons.check_rounded,
            size: 32,
            color: itemColorMapping['icon']![isSelected],
          ),
          backgroundColor: itemColorMapping['background']![isSelected],
        );
    }
  }
}
