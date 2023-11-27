import 'package:flutter/material.dart';
import 'package:icon_animated/icon_animated.dart';
import 'package:menukaran/common/provider.dart';
import 'package:menukaran/common/widgets/header.dart';
import 'package:provider/provider.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class DesktopCopyFailed extends StatefulWidget {
  const DesktopCopyFailed({super.key});
  @override
  State<DesktopCopyFailed> createState() => _DesktopCopyFailedState();
}

class _DesktopCopyFailedState extends State<DesktopCopyFailed> {
  @override
  Widget build(BuildContext context) {
    final text = context.read<ValueProvider>().message;
    return Scaffold(
      appBar: const TitleBar(
        leading: YaruBackButton(),
      ),
      body: Center(
        child: Column(
          children: [
            const IconAnimated(
              active: true,
              size: 200,
              iconType: IconType.error,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: YaruBanner(
                  color: Colors.black,
                  padding: const EdgeInsets.all(20),
                  child: Flexible(
                    child: SingleChildScrollView(
                      child: SelectableText(
                        text,
                        style: TextStyle(
                          fontFamily: 'Ubuntu Mono',
                          color: Colors.white,
                          fontSize:
                              Theme.of(context).textTheme.bodyLarge!.fontSize,
                          textBaseline: TextBaseline.alphabetic,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
