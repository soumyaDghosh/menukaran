import 'dart:io';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

final userName = Platform.environment['USER'];
final user = Platform.environment['NAME'];
const appTitle = 'MenuKaran';
final greeting = 'Hello $user, welcome to $appTitle';
const filledButton1 = 'Create Desktop';
final iconMap = <TimeOfDay, (IconData, String)>{
  if (DateTime.now().hour >= 6 && DateTime.now().hour < 12)
    TimeOfDay.now(): (FeatherIcons.sunrise, 'Good Morning'),
  if (DateTime.now().hour >= 12 && DateTime.now().hour < 18)
    TimeOfDay.now(): (FeatherIcons.sun, 'Good Day'),
  if (DateTime.now().hour >= 18 && DateTime.now().hour < 21)
    TimeOfDay.now(): (FeatherIcons.sunset, 'Good Evening'),
  if (DateTime.now().hour >= 21 && DateTime.now().hour < 21)
    TimeOfDay.now(): (FeatherIcons.moon, 'Good Night'),
  if (DateTime.now().hour >= 0 && DateTime.now().hour < 6)
    TimeOfDay.now(): (FeatherIcons.moon, 'Good Night'),
};

// getent passwd $USER | cut -d : -f 5 | cut -d ', ' -f 1
// getent passwd $USER | cut -d ':' -f 5 | cut -d ',' -f 1
