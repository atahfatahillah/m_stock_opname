import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:m_stock_opname/routers/router_utils.dart';
import 'package:m_stock_opname/views/item_detail_screen.dart';
import 'package:m_stock_opname/views/scanner_screen.dart';

import '../views/home_screen.dart';
import '../views/login_screen.dart';
import '../views/register_screen.dart';
import '../views/splash_screen.dart';

CustomTransitionPage fadePageTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

class AppRouter {
  get router => _router;

  final _router = GoRouter(
      routerNeglect: true,
      debugLogDiagnostics: true,
      initialLocation: APP_PAGE.splashScreen.routePath,
      routes: [
        GoRoute(
          path: APP_PAGE.splashScreen.routePath,
          name: APP_PAGE.splashScreen.routeName,
          pageBuilder: (context, state) => fadePageTransition(
              context: context, state: state, child: const SplashScreen()),
        ),
        GoRoute(
          path: APP_PAGE.home.routePath,
          name: APP_PAGE.home.routeName,
          pageBuilder: (context, state) => fadePageTransition(
              context: context, state: state, child: const HomeScreen()),
          routes: <RouteBase>[
            GoRoute(
                path: APP_PAGE.itemDetailScreen.routePath,
                name: APP_PAGE.itemDetailScreen.routeName,
                pageBuilder: (context, state) {
                  final code = state.pathParameters['code'];
                  return fadePageTransition(
                      context: context,
                      state: state,
                      child: ItemDetailScreen(code: code!));
                }),
            GoRoute(
                path: APP_PAGE.scannerScreen.routePath,
                name: APP_PAGE.scannerScreen.routeName,
                pageBuilder: (context, state) {
                  return fadePageTransition(
                      context: context,
                      state: state,
                      child: const ScannerScreen());
                })
          ],
        ),
        GoRoute(
          path: APP_PAGE.login.routePath,
          name: APP_PAGE.login.routeName,
          pageBuilder: (context, state) => fadePageTransition(
              context: context, state: state, child: const LoginScreen()),
          routes: <RouteBase>[
            GoRoute(
              path: APP_PAGE.register.routePath,
              name: APP_PAGE.register.routeName,
              pageBuilder: (context, state) => fadePageTransition(
                  context: context,
                  state: state,
                  child: const RegisterScreen()),
            )
          ],
        )
      ],
      redirect: (context, state) {
        return null;
      });
}
