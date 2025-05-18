import 'package:dio/dio.dart';
import 'package:pika_master/data/networking/endpoints.dart';
import 'package:pika_master/domain/networking/inetwirking_client_configuration.dart';

class DioConfiguration implements INetworkClientConfiguration {
  @override
  BaseOptions get configuration => BaseOptions(
        connectTimeout: Duration(seconds: 30),
        sendTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
        contentType: 'application/json',
        responseType: ResponseType.json,
        baseUrl: Endpoints.baseEndpoint,
      );
}
