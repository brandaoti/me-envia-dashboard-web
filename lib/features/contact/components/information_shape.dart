import 'package:flutter/material.dart';

import '../../../core/core.dart';

class InformationShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 2
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;

    final double maxPorc = size.width * 0.25;
    final double minPorc = size.width * 0.14;

    final double maxWidth = size.width - maxPorc;
    final double minWidth = maxWidth - minPorc;

    final Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(maxWidth, 0);
    path.lineTo(minWidth, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
