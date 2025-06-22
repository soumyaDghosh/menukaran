import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

class TitleBar extends StatelessWidget implements PreferredSizeWidget {
  const TitleBar({super.key, this.title, this.leading, this.actions});
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return YaruWindowTitleBar(
      title: title,
      leading: leading,
      actions: actions,
      border: BorderSide.none,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size(
        0,
        kToolbarHeight,
      );
}
