import "dart:async";

import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:go_router/go_router.dart";
import "package:midterm_activity/src/controllers/auth_controller.dart";
import "package:midterm_activity/src/enum/enum.dart";
import "package:midterm_activity/src/screens/auth/login.screen.dart";
import "package:midterm_activity/src/screens/home/home.screen.dart";
import "package:midterm_activity/src/screens/home/wrapper.dart";
import "package:midterm_activity/src/screens/index.screen.dart";

/// https://pub.dev/packages/go_router

class GlobalRouter {
  // Static method to initialize the singleton in GetIt
  static void initialize() {
    GetIt.instance.registerSingleton<GlobalRouter>(GlobalRouter());
  }

  // Static getter to access the instance through GetIt
  static GlobalRouter get instance => GetIt.instance<GlobalRouter>();

  static GlobalRouter get I => GetIt.instance<GlobalRouter>();

  late GoRouter router;
  late GlobalKey<NavigatorState> _rootNavigatorKey;
  late GlobalKey<NavigatorState> _shellNavigatorKey;

  FutureOr<String?> handleRedirect(
      BuildContext context, GoRouterState state) async {
    if (AuthController.I.state == AuthState.authenticated) {
      if (state.matchedLocation == LoginScreen.route) {
        return HomeScreen.route;
      }
      return null;
    }
    if (AuthController.I.state != AuthState.authenticated) {
      if (state.matchedLocation == LoginScreen.route) {
        return null;
      }
      return LoginScreen.route;
    }
    return null;
  }

  GlobalRouter() {
    _rootNavigatorKey = GlobalKey<NavigatorState>();
    _shellNavigatorKey = GlobalKey<NavigatorState>();
    router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: HomeScreen.route,
      redirect: handleRedirect,
      refreshListenable: AuthController.I,
      routes: [
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: LoginScreen.route,
          name: LoginScreen.name,
          builder: (context, _) {
            return const LoginScreen();
          },
        ),
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          routes: [
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: HomeScreen.route,
              name: HomeScreen.name,
              builder: (context, _) {
                return const HomeScreen();
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: "/index",
              name: "Wrapped Index",
              builder: (context, _) {
                return const IndexScreen();
              },
            ),
          ],
          builder: (context, state, child) {
            return HomeWrapper(child: child);
          },
        ),
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: IndexScreen.route,
          name: IndexScreen.name,
          builder: (context, _) {
            return const IndexScreen();
          },
          routes: [
            //other routes
          ],
        ),
      ],
    );
  }
}
