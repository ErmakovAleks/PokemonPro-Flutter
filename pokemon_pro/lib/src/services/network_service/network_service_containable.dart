import '../network_service/network_session_processable.dart';

abstract class NetworkServiceContainable {
  // ignore: unused_field
  final NetworkSessionProcessable _networkService;

  const NetworkServiceContainable({required NetworkSessionProcessable service})
      : _networkService = service;
}
