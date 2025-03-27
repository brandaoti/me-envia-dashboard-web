// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutter/foundation.dart';

abstract class WebConfigUrlStrategy {
  static void setup() {
    if (kIsWeb) {
      setUrlStrategy(PathUrlStrategy());
    }
  }

  static void reloadWebPage() {
    window.location.reload();
  }

  static void replaceUrlPath(String url, {bool isReloadPage = false}) {
    if (isReloadPage) {
      window.location.replace(url);
    } else {
      window.history.pushState(null, '', url);
    }
  }
}
