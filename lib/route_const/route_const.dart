import 'package:flutter/material.dart';
import 'package:hospy/home_screen/home_screen.dart';
import 'package:page_transition/page_transition.dart';

Future<dynamic> pushTo({
  Widget? fromPage,
  required BuildContext context,
  required Widget toPage,
  required PageTransitionType style,
}) {
  return Navigator.push(
    context,
    PageTransition(
      type: style,
      childCurrent: fromPage,
      child: toPage,
    ),
  );
}

Future<dynamic> pushNamed({
  Widget? fromPage,
  required BuildContext context,
  required String routeName,
  Object? arguments,
}) {
  return Navigator.push(
    context,
    PageTransition(
      type: PageTransitionType.rightToLeft,
      childCurrent: fromPage,
      child: _buildPageFromRouteName(context, routeName, arguments),
    ),
  );
}

Widget _buildPageFromRouteName(
    BuildContext context, String routeName, Object? arguments) {
  switch (routeName) {
    case '/home':
      return const HomeScreen();

    default:
      return Scaffold(
        body: Center(child: Text('No page found for $routeName')),
      );
  }
}

Future<dynamic> popNamed({
  required BuildContext context,
  required String routeName,
}) {
  return Navigator.popAndPushNamed(context, routeName);
}

Future<dynamic> pushReplacement({
  required BuildContext context,
  required Widget page,
  required PageTransitionType style,
}) {
  return Navigator.pushReplacement(
    context,
    PageTransition(
      child: page,
      type: style,
    ),
  );
}

Future<dynamic> pushReplacementNamed({
  required BuildContext context,
  required String routeName,
  Object? arguments,
}) {
  return Navigator.pushReplacementNamed(
    context,
    routeName,
    arguments: arguments,
  );
}

Future<dynamic> pushAndRemoveAll({
  required BuildContext context,
  required Widget page,
  required PageTransitionType style,
}) {
  return Navigator.pushAndRemoveUntil(
    context,
    PageTransition(
      child: page,
      type: style,
    ),
    (route) => false,
  );
}

Future<dynamic> pushAndRemoveAllNamed({
  required BuildContext context,
  required String routeName,
  Object? arguments,
}) {
  return Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) =>
          _buildPageFromRouteName(context, routeName, arguments),
      settings: RouteSettings(name: routeName, arguments: arguments),
    ),
    (route) => false,
  );
}

Future<dynamic> maybePop({
  required BuildContext context,
  Object? result,
}) {
  return Navigator.maybePop(context, result);
}

Future<dynamic> pushNamedAndRemoveUntil({
  required BuildContext context,
  required String routeName,
  Object? arguments,
  required RoutePredicate predicate,
}) {
  return Navigator.pushNamedAndRemoveUntil(
    context,
    routeName,
    predicate,
    arguments: arguments,
  );
}

Future<dynamic> pushNamedAndRemoveUntilNamed({
  required BuildContext context,
  required String routeName,
  Object? arguments,
  required String removeUntilRouteName,
}) {
  return Navigator.pushNamedAndRemoveUntil(
    context,
    routeName,
    (route) => route.settings.name == removeUntilRouteName,
    arguments: arguments,
  );
}
