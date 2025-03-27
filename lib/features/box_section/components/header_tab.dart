import 'package:flutter/material.dart';
import 'package:maria_me_envia_mobile_admin_web/core/values/values.dart';

class HeaderTab extends StatelessWidget {
  final TabController? tabController;
  final ValueChanged<int> onChange;

  const HeaderTab({
    Key? key,
    this.tabController,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: Decorations.customTabBar,
          ),
        ),
        _tabBar(),
      ],
    );
  }

  Widget _tabBar() {
    return TabBar(
      onTap: onChange,
      controller: tabController,
      labelColor: AppColors.secondary,
      indicatorWeight: 3,
      indicatorSize: TabBarIndicatorSize.tab,
      automaticIndicatorColorAdjustment: true,
      unselectedLabelColor: AppColors.grey400,
      tabs: Strings.customTabBarNames.map((it) => Tab(text: it)).toList(),
    );
  }
}
