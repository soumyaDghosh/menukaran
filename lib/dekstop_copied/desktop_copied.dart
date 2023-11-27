import 'package:flutter/material.dart';
import 'package:menukaran/common/provider.dart';
import 'package:menukaran/common/route.dart' as route;
import 'package:menukaran/common/widgets/header.dart';
import 'package:provider/provider.dart';
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
    bool lightmode = Brightness.light == Theme.of(context).brightness;
    return Scaffold(
      appBar: TitleBar(
        leading: YaruBackButton(
          onPressed: () {
            context.read<ValueProvider>().clearControllers();
            Navigator.pushNamed(context, route.startPage);
          },
        ),
      ),
      body: Center(
        child: YaruAnimatedIcon(
          const YaruAnimatedOkIcon(filled: true),
          size: 200,
          duration: const Duration(seconds: 1),
          color: lightmode ? Colors.greenAccent : Colors.green,
        ),
      ),
    );
  }
}
