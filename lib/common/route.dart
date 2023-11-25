import 'package:flutter/material.dart';
import 'package:menukaran/dekstop_copied/desktop_copied.dart';
import 'package:menukaran/desktop_menu_page/create_desktop.dart';
import 'package:menukaran/start_page/start_page.dart';

const String startPage = 'homepage';
const String createDesktop = 'createdesktop';
const String desktopCopied = 'desktopCopied';
Route<dynamic> routecontroller(RouteSettings settings) {
  switch (settings.name) {
    case startPage:
      return MaterialPageRoute(
        builder: (context) => const StartPage(),
      );
    case createDesktop:
      return MaterialPageRoute(builder: (context) => const CreateDesktop());
    case desktopCopied:
      return MaterialPageRoute(builder: (context) => const DesktopCopied());
    default:
      throw ('No such page!');
  }
}
