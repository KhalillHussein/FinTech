import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

/// This class serves as a base for building API clients.
/// It uses a simple [DIO] client as the main HTTP client.
abstract class BaseService {
  final Dio client;
  final GetStorage storage;

  const BaseService(this.client, [this.storage]) : assert(client != null);
}
