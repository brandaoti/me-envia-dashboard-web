import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CustomInterceptors extends Interceptor {
  final bool useLog;

  CustomInterceptors({
    this.useLog = !kReleaseMode,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('RESPONSE[${response.statusCode}] => PATH: ${response.statusCode}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('ERROR[${err.response?.statusCode}] => PATH: ${err.message}');
    super.onError(err, handler);
  }
}
