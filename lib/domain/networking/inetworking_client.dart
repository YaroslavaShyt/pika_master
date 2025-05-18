import 'package:pika_master/domain/networking/inetwirking_client_configuration.dart';

abstract interface class INetworkClient {
  void init({required INetworkClientConfiguration appConfig});

  Future<dynamic> get({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Object? data,
    dynamic additionalParam,
  });

  Future<dynamic> post({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Object? data,
    dynamic additionalParam,
  });

  Future<dynamic> put({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Object? data,
    dynamic additionalParam,
  });

  Future<dynamic> delete({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Object? data,
    dynamic additionalParam,
  });

  Future<dynamic> patch({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Object? data,
    dynamic additionalParam,
  });
}
