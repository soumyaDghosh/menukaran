import 'package:flutter/material.dart';
import 'package:menukaran/dekstop_copied/desktop_copied.dart';
import 'package:menukaran/desktop_copy_failed/failed_desktop_copy.dart';
import 'package:menukaran/desktop_menu_page/create_desktop.dart';
import 'package:menukaran/list_page/list_page.dart';
import 'package:menukaran/settings_menu/settings_page.dart';
import 'package:menukaran/start_page/start_page.dart';

const String startPage = 'homepage';
const String createDesktop = 'createdesktop';
const String desktopCopied = 'desktopCopied';
const String failedtoCopy = 'failedtoCopy';
const String settingsPage = 'settingspage';
const String listPage = 'listpage';
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
    case failedtoCopy:
      return MaterialPageRoute(builder: (context) => const DesktopCopyFailed());
    case settingsPage:
      return MaterialPageRoute(builder: (context) => const SettingsPage());
    case listPage:
      return MaterialPageRoute(builder: (context) => const ListDesktops());
    default:
      throw ('No such page!');
  }
}
