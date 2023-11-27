import 'dart:io';

final userName = Platform.environment['USER'];
final user = Process.runSync(
  'bash',
  ["-c", "getent passwd $userName"],
  runInShell: true,
).stdout.toString().split(':').elementAt(4).split(',').elementAt(0).toString();
const appTitle = 'MenuKaran';
final greeting = '$user, welcome to $appTitle';
const filledButton1 = 'Create Desktop File';
const desktopFields = {
  'name': ('Desktop Name', 'Mandatory', 1),
  'executable': ('Executable Path', 'Mandatory', 2),
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
