import 'package:dio/dio.dart';

import '../../core/constants/url.dart';
import 'base.dart';

/// Services that retrieves transactions from [ApiService].
class TransactionsService extends BaseService {
  const TransactionsService(Dio client) : super(client);

  /// Get all transactions
  Future<Response> getTransactions() async {
    return client.get(Url.base);
  }
}
