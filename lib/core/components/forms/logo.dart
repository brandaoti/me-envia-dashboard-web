import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core.dart';

class MariaMeEnviaLogo extends StatelessWidget {
  final Color? color;
  final double height;
  final double width;

  const MariaMeEnviaLogo({
    Key? key,
    this.color,
    this.height = 80,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      Svgs.defaultLogo,
      width: width,
      color: color,
      height: height,
    );
  }
}
