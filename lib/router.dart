import 'package:egtool/features/auth/screens/signin.dart';
import 'package:egtool/features/homepage/screens/homepage.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SigninScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SigninScreen(),
      );

    case homepage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const homepage(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
