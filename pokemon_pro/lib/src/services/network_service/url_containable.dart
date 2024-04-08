import '../network_service/http_method.dart';

abstract class URLContainable<T> {
  String scheme = 'https';
  String host = 'ex.traction.one';
  String get path;
  HttpMethod method = HttpMethod.get;
  Map<String, String>? get headers;
  Map<String, dynamic>? get body;
  Map<String, String>? get params;

  T fromJson(Map<String, dynamic> json);
}
