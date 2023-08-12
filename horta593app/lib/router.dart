import 'package:flutter/material.dart';
import 'package:horta593app/screens/homeMenu/homemenu_screen.dart';
import 'package:horta593app/screens/home_screen.dart';
import 'package:horta593app/screens/login/login_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => LoginScreen());
    case MenuScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const MenuScreen());
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                  body: Center(
                child: Text("Pagina no encontrada."),
              )));
  }
}
