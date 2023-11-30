import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yaru_icons/yaru_icons.dart';

const sourceCode = 'https://github.com/soumyaDghosh/menukaran';
final userName = Platform.environment['USER'];
final user = Process.runSync(
  'bash',
  ["-c", "getent passwd $userName"],
  runInShell: true,
).stdout.toString().split(':').elementAt(4).split(',').elementAt(0).toString();
const appTitle = 'MenuKaran';
final greeting = '$user, welcome to $appTitle';
const filledButton1 = 'Create Desktop File';
const generalSettings = {
  'theme1': ('Follow System Theme', 1, Icons.contrast),
  'theme2': ('Use Dark Mode', 2, YaruIcons.clear_night_filled),
};
const desktopFields = {
  'name': ('Desktop Name', 'Mandatory', 1, YaruIcons.insert_text),
  'executable': ('Executable Path', 'Mandatory', 2, YaruIcons.gear),
};
const extraDesktopFields = {
  'genericname': ('GenericName', '', 1, YaruIcons.insert_text),
  'comment': ('Comment', '', 2, YaruIcons.chat_text),
  'onlyshowin': ('OnlyShowIn', '', 3, YaruIcons.computer),
  'tryexec': ('TryExec', '', 4, YaruIcons.gears_filled)
};
const installhelp = [
  'Select the .local/share/applications folder',
  'Please select the folder .local/share/application'
];
final home = Platform.environment['HOME'];
final tempdir = '$home/.menukaran';

const types = ['Application', 'Link', 'Directory'];
final errorMessages = ['Necessary Field: '];

// getent passwd $USER | cut -d : -f 5 | cut -d ', ' -f 1
// getent passwd $USER | cut -d ':' -f 5 | cut -d ',' -f 1
