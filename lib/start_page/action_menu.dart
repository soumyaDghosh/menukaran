import 'package:flutter/material.dart';
import 'package:menukaran/common/route.dart' as route;
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class ActionMenu extends StatelessWidget {
  const ActionMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return YaruIconButton(
      style: ButtonStyle(
        shape: ButtonStyleButton.allOrNull(
          const BeveledRectangleBorder(),
        ),
      ),
      icon: const Icon(YaruIcons.menu),
      onPressed: () => Navigator.pushNamed(context, route.settingsPage),
    );
  }
}
