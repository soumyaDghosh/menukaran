import 'dart:io';
import 'dart:typed_data';

import 'package:desktop_entry/desktop_entry.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:menukaran/common/constants.dart';
import 'package:menukaran/models/desktop_model.dart';
import 'package:menukaran/services/database_helper.dart';
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

  List<String> fieldsSelected = [];
  List<String> optionsSelected = [];
  String? icon;
  String type = 'Application';
  String message = '';
  GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static const fields = 'fields';
  static const options = 'options';

  void getSavedOptions() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    fieldsSelected = prefs.getStringList(fields) ?? [];
    optionsSelected = prefs.getStringList(options) ?? [];
    notifyListeners();
  }

  void iconPath(String path) {
    icon = path;
  }

  void setType(String value) {
    type = value;
    notifyListeners();
  }

  void optionsChange(String option) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    optionsSelected.contains(option)
        ? optionsSelected.remove(option)
        : optionsSelected.add(option);
    prefs.setStringList(options, optionsSelected);
    notifyListeners();
  }

  void manupulateExtraFields(String field) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    fieldsSelected.contains(field)
        ? fieldsSelected.remove(field)
        : fieldsSelected.add(field);

    prefs.setStringList(fields, fieldsSelected);
    notifyListeners();
  }

  dynamic installdesktop(String path, Desktop? desktop) async {
    File file;
    String fileName = path.split('/').last.split('.').first.toLowerCase();
    try {
      DesktopEntry desktopEntry = DesktopEntry(
        type: SpecificationString(type),
        name: SpecificationLocaleString(controllers[0].text),
        exec: SpecificationString(controllers[1].text),
        icon: SpecificationIconString(icon ?? ''),
        tryExec: extraControllers[3].text.isEmpty
            ? null
            : SpecificationString(extraControllers[3].text),
        comment: extraControllers[1].text.isEmpty
            ? null
            : SpecificationLocaleString(extraControllers[1].text),
        genericName: extraControllers[0].text.isEmpty
            ? null
            : SpecificationLocaleString(extraControllers[0].text),
        onlyShowIn: extraControllers[2].text.isEmpty
            ? null
            : SpecificationTypeList(
                [SpecificationString(extraControllers[2].text)],
              ),
      );
      final entry = DesktopFileContents(
          entry: desktopEntry, actions: [], unrecognisedGroups: []);

      file =
          await DesktopFileContents.toFile(Directory(tempdir), fileName, entry);
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
      File('$tempdir/$fileName.desktop').existsSync()
          ? File('$tempdir/$fileName.desktop').deleteSync()
          : null;
      throw ErrorDescription(e.toString());
    }
    print('after error');
    const mimeType = 'text/plain';
    final XFile textFile = XFile.fromData(
      Uint8List.fromList(file.readAsBytesSync()),
      mimeType: mimeType,
      // name: path.split('/').last.split('.').first,
    );
    await textFile.saveTo(path);
    final Desktop model = Desktop(
      id: desktop?.id,
      name: controllers[0].text,
      executable: controllers[1].text,
      filename: path.split('/').last,
      type: type,
      icon: icon,
    );
    if (desktop == null) {
      DataBaseHelper.addDesktop(model);
    } else {
      DataBaseHelper.updateDesktop(model);
    }

    File('$tempdir/$fileName.desktop').existsSync()
        ? File('$tempdir/$fileName.desktop').deleteSync()
        : null;
    clearControllers();
    notifyListeners();
  }

  void setMessage(String value) {
    message = value;
  }

  void clearControllers() {
    icon = '';
    type = 'Application';
    for (final extrafield in extraControllers) {
      extrafield.clear();
    }
    for (final controller in controllers) {
      controller.clear();
    }
  }
}
