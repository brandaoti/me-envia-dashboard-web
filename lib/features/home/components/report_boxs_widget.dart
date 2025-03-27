import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:charts_common/common.dart' as common;
import 'package:charts_flutter/flutter.dart' as chart;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/helpers/extensions.dart';
import '../states/change_interval_type.dart';
import '../../../core/models/models.dart';
import '../../../core/values/values.dart';
import '../model/report_chart_item.dart';

typedef ChangeInterval = void Function(ChangeIntervalType, DateTime);

class ReportBoxsWidget extends StatelessWidget {
  final DateTime finalDate;
  final DateTime initialDate;
  final ChangeInterval onOpenDatePicker;
  final ReportStatusList reportStatusList;

  const ReportBoxsWidget({
    Key? key,
    required this.finalDate,
    required this.initialDate,
    required this.onOpenDatePicker,
    required this.reportStatusList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _header(),
        const VerticalSpacing(
          height: 8,
        ),
        Expanded(
          child: _content(),
        ),
      ],
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _headerText(
          text: Strings.initialDate,
        ),
        _headerDate(
          date: initialDate,
          onPressed: () => onOpenDatePicker(
            ChangeIntervalType.initialDate,
            initialDate,
          ),
        ),
        _headerText(
          text: Strings.finalDate,
        ),
        _headerDate(
          date: finalDate,
          onPressed: () => onOpenDatePicker(
            ChangeIntervalType.finalDate,
            initialDate,
          ),
        ),
      ],
    );
  }

  Widget _headerText({
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: AutoSizeText(
        text,
        style: TextStyles.homeHeaderSubtitle.copyWith(
          color: AppColors.secondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _headerDate({
    required DateTime date,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: Decorations.homeHeaderDate.borderRadius as BorderRadius,
      child: Container(
        padding: Paddings.homeHeaderDate,
        decoration: Decorations.homeHeaderDate,
        child: Row(
          children: [
            AutoSizeText(
              date.toDateAbbreStr,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.homeHeaderSubtitle.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryTextLight,
              ),
            ),
            const HorizontalSpacing(
              width: 4,
            ),
            const Icon(
              Icons.arrow_drop_down_rounded,
              color: AppColors.secondaryTextLight,
            )
          ],
        ),
      ),
    );
  }

  Widget _content() {
    return Container(
      width: double.infinity,
      padding: Paddings.allDefaultSmall,
      decoration: Decorations.cardOrderItem(false),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            Strings.requestedBoxTitle,
            style: TextStyles.homeHeaderTitle.copyWith(
              fontSize: 24,
              color: AppColors.secondary,
              fontWeight: FontWeight.w900,
            ),
          ),
          _reportChars(),
        ],
      ),
    );
  }

  Widget _reportChars() {
    final xItems = reportStatusList.map((status) {
      return ReportChartItem.fromStatus(status);
    }).toList();

    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: chart.BarChart(
              _genaratedListOfRightSideItem(xItems),
              animate: true,
              layoutConfig: _layoutConfig(),
              defaultRenderer: _barRendererConfig(),
              domainAxis: const chart.OrdinalAxisSpec(showAxisLine: false),
            ),
          ),
          _legends(xItems),
        ],
      ),
    );
  }

  chart.BarRendererConfig<String> _barRendererConfig() {
    return chart.BarRendererConfig<String>(
      barRendererDecorator: chart.BarLabelDecorator(),
      maxBarWidthPx: Dimens.orderCardProfileSize.toInt(),
      cornerStrategy: const chart.ConstCornerStrategy(8),
    );
  }

  chart.LayoutConfig _layoutConfig() {
    return chart.LayoutConfig(
      leftMarginSpec: common.MarginSpec.fromPixel(),
      rightMarginSpec: common.MarginSpec.fromPixel(),
      topMarginSpec: common.MarginSpec.fromPixel(minPixel: 18),
      bottomMarginSpec: common.MarginSpec.fromPixel(minPixel: 24),
    );
  }

  List<chart.Series<ReportChartItem, String>> _genaratedListOfRightSideItem(
    List<ReportChartItem> xItems,
  ) {
    return [
      chart.Series<ReportChartItem, String>(
        id: 'Sales',
        data: xItems,
        measureFn: (report, _) => report.count,
        domainFn: (report, _) => report.count.toString(),
        colorFn: (report, _) => report.backgroundColor.shadeDefault,
      ),
    ];
  }

  Widget _legends(List<ReportChartItem> charItems) {
    return Container(
      width: double.infinity,
      padding: Paddings.horizontalSmall,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.spaceBetween,
        children: charItems.map(_legendsItems).toList(),
      ),
    );
  }

  Widget _legendsItems(ReportChartItem item) {
    final backgroundColor = item.backgroundColor.toMaterialColor;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: Decorations.paginateItems(true, backgroundColor),
        ),
        const HorizontalSpacing(
          width: 4,
        ),
        AutoSizeText(
          item.title,
          style: TextStyles.resgitrationAccepTermOfUse.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
