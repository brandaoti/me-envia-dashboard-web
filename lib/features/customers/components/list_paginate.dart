import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/values/values.dart';

class ListPaginate extends StatelessWidget {
  final VoidCallback nextPage;
  final VoidCallback previusPage;
  final ValueChanged<int> onChangeCurrentPage;

  final int totalPage;
  final int currentPage;

  const ListPaginate({
    Key? key,
    this.totalPage = 0,
    this.currentPage = 0,
    required this.nextPage,
    required this.previusPage,
    required this.onChangeCurrentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: _body(),
      width: double.infinity,
      alignment: Alignment.center,
      color: AppColors.whiteDefault,
    );
  }

  Widget _body() {
    return Container(
      child: _listfOfPages(),
      constraints: Sizes.paginate,
    );
  }

  Widget _listfOfPages() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _actionButton(
          Icons.arrow_back_ios_new_rounded,
          onPressed: previusPage,
        ),
        Expanded(
          child: _pages(),
        ),
        _actionButton(
          Icons.arrow_forward_ios_rounded,
          onPressed: nextPage,
        ),
      ],
    );
  }

  Widget _pages() {
    List<Widget> children = [];

    for (int index = 0; index < totalPage; index++) {
      final int indexMoreOne = index + 1;
      children.add(_pageItem(
        index: indexMoreOne,
        isActive: indexMoreOne == currentPage,
        onTap: () => onChangeCurrentPage(indexMoreOne),
      ));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: children,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }

  Widget _pageItem({
    required int index,
    bool isActive = false,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          child: _pageItemText(index.toString(), isActive),
          decoration: Decorations.paginateItems(isActive),
        ),
      ),
    );
  }

  Widget _pageItemText(String lenght, bool isActive) {
    return AutoSizeText(
      lenght,
      style: TextStyles.homeHeaderSubtitle.copyWith(
        fontWeight: FontWeight.w400,
        color: isActive ? AppColors.whiteDefault : AppColors.secondary,
      ),
    );
  }

  Widget _actionButton(
    IconData icon, {
    VoidCallback? onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      padding: Paddings.zero,
      icon: Icon(icon, color: AppColors.secondary),
    );
  }
}
