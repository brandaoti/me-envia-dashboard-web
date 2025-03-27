// ignore: avoid_web_libraries_in_flutter
import 'dart:html' show ImageElement;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class PlatformImage {
  static Widget image(
    String source, {
    BoxFit fit = BoxFit.cover,
    Color? color,
    double? width,
    double? height,
    Alignment aligment = Alignment.center,
  }) {
    return Image(
      image: AssetImage(source),
      fit: fit,
      color: color,
      width: width,
      height: height,
      alignment: aligment,
    );
  }

  static Widget element(
    String src, {
    double radius = 8,
    String? viewTypeId,
    BoxFit fit = BoxFit.cover,
  }) {
    ui.platformViewRegistry.registerViewFactory(
      viewTypeId ?? src,
      (s) => _createImageElement(
        src: src,
        fit: fit,
        radius: radius,
      ),
    );

    return HtmlElementView(viewType: viewTypeId ?? src);
  }

  static ImageElement _createImageElement({
    required String src,
    required BoxFit fit,
    required double radius,
  }) {
    final imageElement = ImageElement()
      ..src = src
      ..draggable = false
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.borderRadius = '${radius}px'
      ..style.objectFit = describeEnum(fit);

    return imageElement;
  }
}
