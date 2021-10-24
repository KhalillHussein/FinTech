import 'package:equatable/equatable.dart';
import 'package:fintech_app/data/models/category.dart';
import 'package:fintech_app/data/models/transaction.dart';
import 'package:flutter/foundation.dart';

class DebitsController with ChangeNotifier {
  List<Transaction> _debits;
  List<Transaction> _filteredDebits;
  List<TransactionCategory> transactionCategories;
  ValidationItem _textFrom = ValidationItem(null, null);

  ValidationItem _textTo = ValidationItem(null, null);

  ValidationItem get textFrom => _textFrom;

  ValidationItem get textTo => _textTo;

  bool get isFormValid {
    if (_textFrom.value != null && _textTo.value != null) {
      if (double.tryParse(_textFrom.value) != null &&
          double.tryParse(_textTo.value) != null) {
        if (double.parse(_textFrom.value) < double.tryParse(_textTo.value)) {
          return true;
        }
        return false;
      }

      return false;
    } else {
      return false;
    }
  }

  void changeFromField(String value) {
    if (value.isNotEmpty) {
      _textFrom = ValidationItem(value, null);
    } else {
      _textFrom = ValidationItem(value, 'Неверный диапазон');
    }
    notifyListeners();
  }

  void changeToField(String value) {
    if (value.isNotEmpty) {
      _textTo = ValidationItem(value, null);
    } else {
      _textTo = ValidationItem(value, 'Неверный диапазон');
    }
    notifyListeners();
  }

  final Query query = Query();

  List<Transaction> get debits => _filteredDebits.toSet().toList();

  void update(List<Transaction> newTransactions) {
    _debits = [
      for (final transaction in newTransactions)
        if (transaction.isDebit) transaction
    ];
    final List<String> categoriesLabels = {
      for (final transaction in _debits)
        transaction.toTypeByMMC ?? transaction.toTypeByComment
    }.toList();
    transactionCategories = [
      for (final category in categoriesLabels)
        TransactionCategory(name: category),
    ];

    _filteredDebits = _debits;
    notifyListeners();
  }

  void selectCategory(TransactionCategory newCategory) {
    for (var category in transactionCategories) {
      if (category.name == newCategory.name) {
        category = newCategory;
      }
    }
  }

  void filter() {
    _filteredDebits = _debits
        .where(
          (transaction) =>
              (query?.categories == null ||
                  query.categories.contains(transaction.toTypeByMMC ??
                      transaction.toTypeByComment)) &&
              (query?.period == null ||
                  (transaction.tranDate.isAfter(query.period.first) &&
                      transaction.tranDate.isBefore(query.period.last))) &&
              (query?.amounts == null ||
                  (transaction.amount >= query.amounts.first &&
                      transaction.amount <= query.amounts.last)),
        )
        .toList();
    notifyListeners();
  }
}

class ValidationItem {
  final String value;
  final String error;

  const ValidationItem(
    this.value,
    this.error,
  );
}

class Query extends Equatable {
  List<String> categories;
  List<DateTime> period;
  List<double> amounts;

  Query({this.categories, this.period, this.amounts});

  void reset() {
    categories = null;
    period = null;
    amounts = null;
  }

  @override
  List<Object> get props => [
        categories,
        period,
        amounts,
      ];
}
