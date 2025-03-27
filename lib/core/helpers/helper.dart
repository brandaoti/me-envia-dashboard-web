import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../values/values.dart';

abstract class Helper {
  static Future<void> launchTo(String url, {bool useWebView = false}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('erro de launch');
    }

    if (useWebView) {
      await launch(url, forceWebView: true);
    }
  }

  static void showSnackBarCopiedToClipboard(
    BuildContext context,
    String message, {
    Color backgroundColor = AppColors.secondary,
    Duration duration = Durations.splashAnimation,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: duration,
      content: Text(message),
      backgroundColor: backgroundColor,
    ));
  }
}
