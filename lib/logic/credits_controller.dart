import 'package:charts_flutter/flutter.dart' as charts;
import 'package:equatable/equatable.dart';
import 'package:fintech_app/data/models/category.dart';
import 'package:fintech_app/data/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';

class CreditsController with ChangeNotifier {
  List<Transaction> _credits;
  List<Transaction> _filteredCredits;
  List<String> _categoriesLabels;
  List<TransactionCategory> transactionCategories;
  ValidationItem _textFrom = ValidationItem(null, null);

  ValidationItem _textTo = ValidationItem(null, null);

  ValidationItem get textFrom => _textFrom;

  ValidationItem get textTo => _textTo;

  final List<CreditSeries> _creditSeries = [];

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

  double get summCredit {
    final List<double> values = [
      for (final credit in _filteredCredits) credit.amount
    ];
    return values.sum;
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

  List<Transaction> get credits => _filteredCredits.toSet().toList();

  List<CreditSeries> get creditSeries => _creditSeries.toSet().toList();

  void update(List<Transaction> newTransactions) {
    _credits = [
      for (final transaction in newTransactions)
        if (!transaction.isDebit) transaction
    ];
    _categoriesLabels = {
      for (final transaction in _credits)
        transaction.toTypeByMMC ?? transaction.toTypeByComment
    }.toList();
    transactionCategories = [
      for (final category in _categoriesLabels)
        TransactionCategory(name: category),
    ];

    _filteredCredits = _credits;

    ///
    ///
    calculateCharSeries();

    notifyListeners();
    print(_creditSeries);
  }

  void calculateCharSeries() {
    for (final category in _categoriesLabels) {
      double summ = 0;
      int barColor = 0xFFFFFFFF;
      for (final credit in _filteredCredits) {
        if (credit.toTypeByComment
                ?.toLowerCase()
                ?.contains(category.toLowerCase()) ??
            credit.toTypeByMMC
                ?.toLowerCase()
                ?.contains(category.toLowerCase())) {
          summ += credit.amount;
          barColor = credit.toColorByMMC ?? credit.toColorByComment;
        }
      }
      _creditSeries.add(
        CreditSeries(
          category: category,
          amount: summ,
          barColor: charts.ColorUtil.fromDartColor(
            Color(barColor),
          ),
        ),
      );
    }
  }

  void selectCategory(TransactionCategory newCategory) {
    for (var category in transactionCategories) {
      if (category.name == newCategory.name) {
        category = newCategory;
      }
    }
  }

  void filter() {
    _filteredCredits = _credits
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
    _creditSeries.clear();
    calculateCharSeries();
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

class CreditSeries extends Equatable {
  final String category;
  final double amount;
  final charts.Color barColor;

  CreditSeries(
      {@required this.category,
      @required this.amount,
      @required this.barColor});

  @override
  List<Object> get props => [category, amount, barColor];
}
