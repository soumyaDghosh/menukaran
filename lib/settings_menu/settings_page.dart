import 'package:flutter/material.dart';
import 'package:menukaran/common/constants.dart';
import 'package:menukaran/common/provider.dart';
import 'package:provider/provider.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YaruWindowTitleBar(
        title: Text('Settings'),
        border: BorderSide.none,
        backgroundColor: Colors.transparent,
        leading: YaruBackButton(),
      ),
      body: Column(
        children: [
          YaruSection(
            margin: const EdgeInsets.all(40),
            padding: EdgeInsets.zero,
            headlinePadding:
                const EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
            headline: const Text('Enable Additional Fields'),
            child: Column(
              children: [
                for (final fields in extraDesktopFields.entries)
                  YaruSwitchListTile(
                    title: Text(fields.value.$1),
                    value: context
                        .read<ValueProvider>()
                        .optionSelected
                        .contains(fields.key),
                    onChanged: (v) => setState(() {
                      context
                          .read<ValueProvider>()
                          .manupulateExtraFields(fields.key);
                    }),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
