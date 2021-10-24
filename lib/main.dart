import 'package:device_preview/device_preview.dart';
import 'package:dio/dio.dart';
import 'package:fintech_app/core/constants/routes.dart';
import 'package:fintech_app/data/repositories/transactions.dart';
import 'package:fintech_app/data/services/transactions.dart';
import 'package:fintech_app/logic/credits_controller.dart';
import 'package:fintech_app/logic/debits_controller.dart';
import 'package:fintech_app/logic/transactions_controller.dart';
import 'package:fintech_app/presentation/router/router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'core/themes/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final httpClient = Dio();
  final storage = GetStorage();
  AppTheme.setStatusBarColor();
  AppTheme.setDeviceOrientation();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => TransactionsRepository(
          TransactionsService(httpClient),
        ),
      ),
      ChangeNotifierProxyProvider<TransactionsRepository,
          TransactionsController>(
        create: (ctx) => TransactionsController(),
        update: (ctx, model, controller) =>
            controller..update(model.transactions),
      ),
      ChangeNotifierProxyProvider<TransactionsRepository, DebitsController>(
        create: (ctx) => DebitsController(),
        update: (ctx, model, controller) =>
            controller..update(model.transactions),
      ),
      ChangeNotifierProxyProvider<TransactionsRepository, CreditsController>(
        create: (ctx) => CreditsController(),
        update: (ctx, model, controller) =>
            controller..update(model.transactions),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 704),
      builder: () => MaterialApp(
        title: 'Banking App',
        // locale: DevicePreview.locale(context), // Add the locale here
        localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
        supportedLocales: const [Locale('ru')],
        // builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: AppRoutes.history,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
