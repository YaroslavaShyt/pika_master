import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pika_master/core/logger/logger.dart';

class LoggerInterceptor extends Interceptor {
  factory LoggerInterceptor() {
    return _interceptor;
  }

  LoggerInterceptor._internal();

  static final LoggerInterceptor _interceptor = LoggerInterceptor._internal();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final message = StringBuffer();

    message
      ..write('Request │ ${options.method} │ ${options.path}\n')
      ..write('PARAMS ${options.queryParameters} \n');

    try {
      if (options.data != null) {
        message.write('BODY:\n');
        final String value =
            const JsonEncoder.withIndent('  ').convert(options.data);
        message.write(value);
      }

      logger.i(message);
    } catch (e) {
      message.write('Cant convert message content, skip');
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final message = StringBuffer();

    message
      ..writeln('API ERROR: ')
      ..writeln('PATH: ${err.requestOptions.path}');

    if (err.response != null) {
      message.writeln('STATUS CODE: ${err.response?.statusCode?.toString()}');
    }

    if (err.response != null) {
      final String value =
          const JsonEncoder.withIndent('  ').convert(err.response?.data);
      message.writeln(value);
    }

    logger.e(message, error: err);

    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final message = StringBuffer();

    final uri = response.requestOptions.uri;
    final method = response.requestOptions.method;

    message.write(
      'Response │ $method │ ${response.statusCode} ${response.statusMessage} │ ${uri.toString()}',
    );

    message.write('\n');

    _printResponseBody(response, message);

    logger.i(message);

    handler.next(response);
  }

  void _printResponseBody(Response<dynamic> response, StringBuffer message) {
    String value;

    if (response.data == null) return;

    final data = response.data;
    try {
      value = const JsonEncoder.withIndent('  ').convert(data);
    } on Exception catch (_) {
      value = '';
    }

    message.write(value);
  }
}
