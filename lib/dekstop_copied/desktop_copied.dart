import 'package:flutter/material.dart';
import 'package:menukaran/common/route.dart' as route;
import 'package:menukaran/common/widgets/header.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class DesktopCopied extends StatefulWidget {
  const DesktopCopied({super.key});

  @override
  State<DesktopCopied> createState() => _DesktopCopiedState();
}

class _DesktopCopiedState extends State<DesktopCopied> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(
        leading: YaruBackButton(
          onPressed: () => Navigator.pushNamed(context, route.startPage),
        ),
      ),
      body: const Center(
        child: YaruAnimatedIcon(
          YaruAnimatedOkIcon(filled: true),
          size: 200,
          duration: Duration(seconds: 1),
        ),
      ),
    );
  }
}