import 'dart:convert';
import 'package:async/async.dart';
import 'package:http/http.dart' show Client, Response;
import '../network_service/http_method.dart';
import '../network_service/url_containable.dart';
import '../network_service/network_session_processable.dart';

class NetworkService implements NetworkSessionProcessable {
  static final NetworkService _instance = NetworkService._();
  final Client _client = Client();

  NetworkService._();

  factory NetworkService.shared() => _instance;

  @override
  Future<Result<T>> sendRequest<T>(URLContainable<T> requestModel) async {
    Uri url = Uri.parse(
        '${requestModel.scheme}://${requestModel.host}${requestModel.path}');
    if (requestModel.params != null) {
      url = url.replace(queryParameters: requestModel.params);
    }

    Response response;

    try {
      switch (requestModel.method) {
        case HttpMethod.get:
          response = await _client.get(url, headers: requestModel.headers);
        case HttpMethod.post:
          response = await _client.post(
            url,
            headers: requestModel.headers,
            body: json.encode(requestModel.body),
          );
        case HttpMethod.put:
          response = await _client.put(
            url,
            headers: requestModel.headers,
            body: json.encode(requestModel.body),
          );
        case HttpMethod.patch:
          response = await _client.patch(
            url,
            headers: requestModel.headers,
            body: json.encode(requestModel.body),
          );
        case HttpMethod.delete:
          response = await _client.delete(
            url,
            headers: requestModel.headers,
            body: json.encode(requestModel.body),
          );
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final parsedJson = json.decode(response.body);
        try {
          return Result.value(requestModel.fromJson(parsedJson));
        } on TypeError {
          return Result.value(requestModel.fromJson(parsedJson[0]));
        }
      } else {
        return Result.error(
            '<!> Response error, status code = ${response.statusCode}, url = ${url.toString()}');
      }
    } catch (error) {
      return Result.error(
          '<!> Response error, description: ${error.toString()}');
    }
  }
}
