import 'package:flutter/material.dart';

class Navigate {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static NavigatorState get _navigator => navigatorKey.currentState!;

  static toNamed(String routeName) => _navigator.pushNamed(routeName);
  static backUntil(RoutePredicate predicate) => _navigator.popUntil(predicate);
  static Future<T?> to<T extends Object?>(Widget page) =>
      _navigator.push<T>(MaterialPageRoute(builder: (_) => page));
  static off(Widget page) =>
      _navigator.pushReplacement(MaterialPageRoute(builder: (_) => page));
  static offNamed(String routeName) =>
      _navigator.pushReplacementNamed(routeName);

  static back<T extends Object?>([T? result]) => _navigator.pop(result);
}
