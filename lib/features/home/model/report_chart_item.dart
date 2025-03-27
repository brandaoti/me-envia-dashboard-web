// ignore: implementation_imports
import 'package:charts_common/src/common/palette.dart' as pallette;

import 'package:charts_common/common.dart' as commom;
import 'package:flutter/material.dart';

import '../../../core/models/models.dart';
import '../../../core/types/types.dart';
import '../../../core/values/values.dart';

typedef ReportChartItemList = List<ReportChartItem>;

class ReportChartItemColor extends pallette.Palette {
  final commom.Color color;

  const ReportChartItemColor({
    required this.color,
  });

  factory ReportChartItemColor.fromMaterialColor(Color primary) {
    return ReportChartItemColor(
      color: commom.Color(r: primary.red, g: primary.green, b: primary.blue),
    );
  }

  Color get toMaterialColor {
    return Color.fromRGBO(color.r, color.g, color.b, 1.0);
  }

  @override
  commom.Color get shadeDefault => color;
}

class ReportChartItem {
  final int count;
  final String title;
  final ReportChartItemColor backgroundColor;

  const ReportChartItem({
    required this.count,
    required this.title,
    required this.backgroundColor,
  });

  factory ReportChartItem.fromStatus(ReportStatus report) {
    Color color;
    String titleValue;

    switch (report.status) {
      case ReportStatusType.awaitingFee:
        color = AppColors.chartOrangeColor;
        titleValue = Strings.reportStatus.first;
        break;
      case ReportStatusType.awaitingPayment:
        color = AppColors.chartPinkColor;
        titleValue = Strings.reportStatus[1];
        break;
      case ReportStatusType.paymentAccept:
        color = AppColors.chartPupleColorLight;
        titleValue = Strings.reportStatus[2];
        break;
      case ReportStatusType.objectDelivered:
        color = AppColors.chartGreenColor;
        titleValue = Strings.reportStatus.last;
        break;
    }

    return ReportChartItem(
      title: titleValue,
      count: report.count,
      backgroundColor: ReportChartItemColor.fromMaterialColor(color),
    );
  }

  @override
  String toString() =>
      'ReportChartItem(count: $count, title: $title, backgroundColor: $backgroundColor)';
}
