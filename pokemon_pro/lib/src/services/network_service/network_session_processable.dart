import 'package:async/async.dart';
import '../network_service/url_containable.dart';

abstract interface class NetworkSessionProcessable {
  Future<Result<T>> sendRequest<T>(URLContainable<T> requestModel);
}
