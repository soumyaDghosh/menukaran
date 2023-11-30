import 'dart:io';
import 'dart:typed_data';

import 'package:desktop_entry/desktop_entry.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:menukaran/common/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ValueProvider extends ChangeNotifier {
  final List<TextEditingController> controllers = List.generate(
    desktopFields.length,
    (index) => TextEditingController(),
  );
  final List<TextEditingController> extraControllers = List.generate(
    extraDesktopFields.length,
    (index) => TextEditingController(),
  );
  List<String> optionSelected = [];
  String icon = '';
  String type = 'Application';
  String message = '';
  GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static const options = 'options';

  void getSavedOptions() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    optionSelected = prefs.getStringList(options) ?? [];
    notifyListeners();
  }

  void iconPath(String path) {
    icon = path;
  }

  void setType(String value) {
    type = value;
    notifyListeners();
  }

  void manupulateExtraFields(String option) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (optionSelected.contains(option)) {
      optionSelected.remove(option);
    } else {
      optionSelected.add(option);
    }
    prefs.setStringList(options, optionSelected);
    notifyListeners();
  }

  dynamic installdesktop(String path) async {
    File file;
    try {
      DesktopEntry desktopEntry = DesktopEntry(
          type: SpecificationString(type),
          name: SpecificationLocaleString(controllers[0].text),
          exec: SpecificationString(controllers[1].text),
          icon: SpecificationIconString(icon),
          tryExec: SpecificationString(extraControllers[3].text),
          comment: SpecificationLocaleString(extraControllers[1].text),
          genericName: SpecificationLocaleString(extraControllers[0].text),
          onlyShowIn: SpecificationTypeList(
              [SpecificationString(extraControllers[2].text)]));
      final entry = DesktopFileContents(
          entry: desktopEntry, actions: [], unrecognisedGroups: []);

      file = await DesktopFileContents.toFile(
          Directory(tempdir), path.split('/').last.split('.').first, entry);
      final fileValidate =
          await Process.run('desktop-file-validate', [file.path]);
      checkProcessStdErr(fileValidate);
      // await installDesktopFileFromMemory(
      //   tempDir: Directory(tempdir),
      //   contents: entry,
      //   filenameNoExtension: 'test',
      //   installationPath: path,
      // );
    } catch (e) {
      throw ErrorDescription(e.toString());
    }
    const mimeType = 'text/plain';
    final XFile textFile = XFile.fromData(
      Uint8List.fromList(file.readAsBytesSync()),
      mimeType: mimeType,
      // name: path.split('/').last.split('.').first,
    );
    await textFile.saveTo(path);

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
