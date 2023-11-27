import 'dart:io';

import 'package:desktop_entry/desktop_entry.dart';
import 'package:flutter/material.dart';
import 'package:menukaran/common/constants.dart';

class ValueProvider extends ChangeNotifier {
  final List<TextEditingController> controllers = List.generate(
    desktopFields.length,
    (index) => TextEditingController(),
  );
  String icon = '';
  String type = 'Application';
  String message = '';
  GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void iconPath(String path) {
    icon = path;
  }

  void setType(String value) {
    type = value;
    notifyListeners();
  }

  dynamic installdesktop(String path) async {
    try {
      DesktopEntry desktopEntry = DesktopEntry(
        type: SpecificationString(type),
        name: SpecificationLocaleString(controllers[0].text),
        exec: SpecificationString(controllers[1].text),
        icon: SpecificationIconString(icon),
        tryExec: SpecificationString(controllers[5].text),
        comment: SpecificationLocaleString(controllers[3].text),
        genericName: SpecificationLocaleString(controllers[2].text),
      );
      final entry = DesktopFileContents(
          entry: desktopEntry, actions: [], unrecognisedGroups: []);

      await installDesktopFileFromMemory(
        tempDir: Directory(tempdir),
        contents: entry,
        filenameNoExtension: 'test',
        installationPath: path,
      );
    } catch (e) {
      throw ErrorDescription(e.toString());
    }
    notifyListeners();
  }

  void setMessage(String value) {
    message = value;
  }

  void clearControllers() {
    for (final controller in controllers) {
      controller.clear();
    }
  }
}
