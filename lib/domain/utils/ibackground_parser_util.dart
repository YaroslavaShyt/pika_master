abstract interface class IParseDataUtil {
  Future<T> fromJson<T>({
    required Map<String, dynamic> json,
    required T Function(Map<String, dynamic>) fromJsonFunction,
  });
}
