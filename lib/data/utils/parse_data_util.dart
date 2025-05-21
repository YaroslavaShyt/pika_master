import 'package:flutter/foundation.dart';
import 'package:pika_master/domain/utils/ibackground_parser_util.dart';

class ParseDataUtil implements IParseDataUtil {
  @override
  Future<T> fromJson<T>({
    required Map<String, dynamic> json,
    required T Function(Map<String, dynamic>) fromJsonFunction,
  }) async {
    return compute(fromJsonFunction, json);
  }
}
