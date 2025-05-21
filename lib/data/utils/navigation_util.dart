import 'package:flutter/widgets.dart';
import 'package:pika_master/core/routing/routes.dart';
import 'package:pika_master/domain/utils/inavigation_util.dart';

class NavigationUtil implements INavigationUtil {
  factory NavigationUtil() {
    return _instance;
  }

  NavigationUtil._internal();

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final NavigationUtil _instance = NavigationUtil._internal();

  @override
  Future<dynamic> navigateTo<T extends Object?>(
    String routeName, {
    bool allowBackNavigation = true,
    dynamic data,
  }) {
    if (allowBackNavigation == false) {
      return navigatorKey.currentState!
          .pushReplacementNamed(routeName, arguments: data);
    }
    return navigatorKey.currentState!.pushNamed(routeName, arguments: data);
  }

  @override
  Future<dynamic> navigateToAndMakeRoot<T extends Object?>(
    String routeName, {
    dynamic data,
  }) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: data,
    );
  }

  @override
  void navigateBack<T extends Object?>({T? data}) {
    navigatorKey.currentState?.pop(data);
  }

  @override
  void navigateBackUntilNamed(String named) {
    navigatorKey.currentState?.popUntil(
      (route) {
        if (named == Routes.routeMain && route.settings.name == '/') {
          return true;
        }
        if (route.isFirst && route.settings.name == '/') {
          return true;
        }
        return named == route.settings.name;
      },
    );
  }

  @override
  bool get canPop => navigatorKey.currentState!.canPop();

  @override
  void navigateBackToStart() {
    navigatorKey.currentState!.popUntil(
      (route) => !navigatorKey.currentState!.canPop(),
    );
  }

  @override
  Future navigateToAndReplace<T extends Object?>(
    String routeName, {
    dynamic data,
  }) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => route.settings.name == routeName,
      arguments: data,
    );
  }
}
