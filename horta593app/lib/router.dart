import 'package:flutter/material.dart';
import 'package:horta593app/screens/home/base_screen.dart';
import 'package:horta593app/screens/login/login_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => LoginScreen());
    case BaseScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BaseScreen());
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                  body: Center(
                child: Text("Pagina no encontrada."),
              )));
  }
}
