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

  void iconPath(String path) {
    icon = path;
  }

  void installdesktop() async {
    DesktopEntry desktopEntry = DesktopEntry(
      type: SpecificationString(controllers[2].text),
      name: SpecificationLocaleString(controllers[0].text),
      exec: SpecificationString(controllers[1].text),
      icon: SpecificationIconString(icon),
    );
    final entry = DesktopFileContents(
        entry: desktopEntry, actions: [], unrecognisedGroups: []);
    await installDesktopFileFromMemory(
      tempDir: Directory('/home/$userName/Android'),
      contents: entry,
      filenameNoExtension: 'test',
      installationPath: '/home/$userName/.local/share/applications',
    );
  }

  void clearControllers() {
    for (final controller in controllers) {
      controller.clear();
    }
  }
}
