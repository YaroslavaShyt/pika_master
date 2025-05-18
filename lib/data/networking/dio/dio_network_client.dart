import 'dart:async';

import 'package:dio/dio.dart';
import 'package:pika_master/data/networking/interceptors/logger_interceptor.dart';
import 'package:pika_master/domain/networking/inetwirking_client_configuration.dart';
import 'package:pika_master/domain/networking/inetworking_client.dart';

class DioNetworkClient implements INetworkClient {
  late final Dio _dio;

  @override
  void init({required INetworkClientConfiguration appConfig}) {
    _dio = Dio(appConfig.configuration);

    _dio.transformer = BackgroundTransformer();

    _dio.interceptors.addAll([
      LoggerInterceptor(),
    ]);
  }

  @override
  Future<Response?> get({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Object? data,
    dynamic additionalParam,
    Options? options,
  }) async {
    try {
      final Response response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        data: data,
        options: options,
      );
      return response;
    } on DioException catch (_) {
      return null;
    }
  }

  @override
  Future<Response?> delete({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Object? data,
    dynamic additionalParam,
    Options? options,
  }) async {
    try {
      final Response response = await _dio.delete(
        endpoint,
        queryParameters: queryParameters,
        data: data,
        options: options,
      );
      return response;
    } on DioException catch (_) {
      return null;
    }
  }

  @override
  Future<Response?> patch({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Object? data,
    dynamic additionalParam,
    Options? options,
  }) async {
    try {
      final Response response = await _dio.patch(
        endpoint,
        queryParameters: queryParameters,
        data: data,
        options: options,
      );
      return response;
    } on DioException catch (_) {
      return null;
    }
  }

  @override
  Future<Response?> post({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Object? data,
    dynamic additionalParam,
    Options? options,
  }) async {
    try {
      final Response response = await _dio.post(
        endpoint,
        queryParameters: queryParameters,
        data: data,
        options: options,
      );
      return response;
    } on DioException catch (_) {
      return null;
    }
  }

  @override
  Future<Response?> put({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Object? data,
    dynamic additionalParam,
    Options? options,
  }) async {
    try {
      final Response response = await _dio.put(
        endpoint,
        queryParameters: queryParameters,
        data: data,
        options: options,
      );
      return response;
    } on DioException catch (_) {
      return null;
    }
  }
}
