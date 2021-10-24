import 'package:dio/dio.dart';

import '../../core/exceptions/api_exception.dart';
import '../models/transaction.dart';
import '../services/transactions.dart';
import 'base.dart';

/// Repository that perform login and logout operations.
class TransactionsRepository extends BaseRepository<TransactionsService> {
  TransactionsRepository(TransactionsService service) : super(service);

  List<Transaction> _transactions;

  List<Transaction> get transactions => _transactions;

  @override
  Future<void> loadData() async {
    try {
      // Try to load the data using [ApiService]
      final response = await service.getTransactions();
      _transactions = [
        for (final transaction in response.data['data'])
          Transaction.fromMap(transaction)
      ];
      finishLoading();
    } on DioError catch (dioError) {
      receivedError(ApiException.fromDioError(dioError).message);
    } catch (error) {
      rethrow;
      receivedError(error.toString());
    }
  }
}
