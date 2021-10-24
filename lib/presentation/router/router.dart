import 'package:fintech_app/core/constants/routes.dart';
import 'package:fintech_app/core/exceptions/route_exception.dart';
import 'package:fintech_app/presentation/screens/credit/credit_imports.dart';
import 'package:fintech_app/presentation/screens/debit/debit_imports.dart';
import 'package:fintech_app/presentation/screens/history/history_imports.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.history:
        return MaterialPageRoute<HistoryScreen>(
          builder: (_) => HistoryScreen(),
        );
      case AppRoutes.debit:
        return MaterialPageRoute<DebitScreen>(
          builder: (_) => DebitScreen(),
        );
      case AppRoutes.credit:
        return MaterialPageRoute<DebitScreen>(
          builder: (_) => CreditScreen(),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
