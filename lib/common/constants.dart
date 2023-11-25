import 'dart:io';

final userName = Platform.environment['USER'];
final user = Platform.environment['NAME'];
const appTitle = 'MenuKaran';
final greeting = 'Hello $user, welcome to $appTitle';
const filledButton1 = 'Create Desktop';
const desktopFields = {
  'name': ('Desktop Name', 'Mandatory', 1),
  'executable': ('Executable Path', 'Mandatory', 2),
  'type': ('Type', '', 3),
};

// getent passwd $USER | cut -d : -f 5 | cut -d ', ' -f 1
// getent passwd $USER | cut -d ':' -f 5 | cut -d ',' -f 1
