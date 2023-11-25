import 'package:flutter/material.dart';

const String homePage = 'homepage';
const String settingsPage = 'settingspage';
Route<dynamic> routecontroller(RouteSettings settings) {
  switch (settings.name) {
    case homePage:
      return MaterialPageRoute(
        builder: (context) => const HomePage(),
      );
    case settingsPage:
      return MaterialPageRoute(builder: (context) => const SettingsPage());
    default:
      throw ('No such page!');
  }
}
