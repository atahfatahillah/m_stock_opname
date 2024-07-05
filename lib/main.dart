import 'package:flutter/material.dart';
import 'package:m_stock_opname/utils/app_theme.dart';
import 'package:m_stock_opname/utils/locator.dart';

import 'routers/app_router.dart';

void main() async {
  setupLocator();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final router = AppRouter().router;

  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        theme: AppTheme.lightThemeData(context),
        darkTheme: AppTheme.darkThemeData(context),
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        routeInformationProvider: router.routeInformationProvider,
        debugShowCheckedModeBanner: false);
  }
}
