import 'package:intl/intl.dart';

class AppFormatters {
  static NumberFormat numberFormatter = NumberFormat.decimalPattern('Ru');
  static NumberFormat numberFormatterWithoutDecimal =
      NumberFormat.currency(locale: 'Ru', decimalDigits: 0, symbol: '₽');

  static NumberFormat compactFormatter =
      NumberFormat.compactCurrency(locale: 'Ru', decimalDigits: 0, symbol: '₽');
}
