import 'package:flutter/material.dart';
import 'package:menukaran/common/constants.dart';
import 'package:menukaran/common/provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> generalSettingsColumn = [];
    if (!context.read<ValueProvider>().optionsSelected.contains('theme1')) {
      for (final options in generalSettings.entries) {
        generalSettingsColumn.add(
          YaruSwitchListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: options.key == generalSettings.entries.first.key
                    ? const Radius.circular(10)
                    : Radius.zero,
                topRight: options.key == generalSettings.entries.first.key
                    ? const Radius.circular(10)
                    : Radius.zero,
              ),
            ),
            tileColor: Theme.of(context).highlightColor,
            title: Row(
              children: [
                Icon(options.value.$3),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(options.value.$1),
                ),
              ],
            ),
            value: context
                .read<ValueProvider>()
                .optionsSelected
                .contains(options.key),
            onChanged: (v) => setState(
              () {
                context.read<ValueProvider>().optionsChange(options.key);
              },
            ),
          ),
        );
      }
    } else {
      generalSettingsColumn.add(
        YaruSwitchListTile(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          tileColor: Theme.of(context).highlightColor,
          title: Row(
            children: [
              Icon(generalSettings.entries.first.value.$3),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(generalSettings.entries.first.value.$1),
              ),
            ],
          ),
          value: context
              .read<ValueProvider>()
              .optionsSelected
              .contains(generalSettings.entries.first.key),
          onChanged: (v) => setState(
            () {
              context
                  .read<ValueProvider>()
                  .optionsChange(generalSettings.entries.first.key);
            },
          ),
        ),
      );
    }

    generalSettingsColumn.add(
      ListTile(
        tileColor: Theme.of(context).highlightColor,
        leading: const Icon(Icons.info),
        title: const Text('About the app'),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: YaruIconButton(
            icon: const Icon(Icons.code),
            onPressed: () => launchUrl(Uri.parse(sourceCode)),
          ),
        ),
      ),
    );

    generalSettingsColumn.add(
      ListTile(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        tileColor: Theme.of(context).highlightColor,
        leading: const Icon(Icons.security),
        title: const Text('Report an Issue'),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: YaruIconButton(
            icon: const Icon(Icons.link),
            onPressed: () => launchUrl(Uri.parse(sourceCode)),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: const YaruWindowTitleBar(
        title: Text('Settings'),
        border: BorderSide.none,
        backgroundColor: Colors.transparent,
        leading: YaruBackButton(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 40,
              top: 20,
            ),
            child: Text('General Settings'),
          ),
          YaruSection(
            padding: EdgeInsets.zero,
            margin:
                const EdgeInsets.only(top: 20, left: 40, right: 40, bottom: 20),
            child: Column(children: generalSettingsColumn),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 40,
              top: 20,
            ),
            child: Text('Enable Additional Options'),
          ),
          YaruSection(
            margin:
                const EdgeInsets.only(top: 20, left: 40, right: 40, bottom: 20),
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                for (final fields in extraDesktopFields.entries)
                  YaruSwitchListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: fields.key == 'tryexec'
                            ? const Radius.circular(10)
                            : Radius.zero,
                        bottomRight: fields.key == 'tryexec'
                            ? const Radius.circular(10)
                            : Radius.zero,
                        topLeft: fields.key == 'genericname'
                            ? const Radius.circular(10)
                            : Radius.zero,
                        topRight: fields.key == 'genericname'
                            ? const Radius.circular(10)
                            : Radius.zero,
                      ),
                    ),
                    tileColor: Theme.of(context).highlightColor,
                    title: Row(
                      children: [
                        Icon(
                          fields.value.$4,
                          size: kYaruIconSize / 1.15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(fields.value.$1),
                        ),
                      ],
                    ),
                    value: context
                        .read<ValueProvider>()
                        .fieldsSelected
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
          const Center(
            child: Text('Made with Love in Bharat <3'),
          )
        ],
      ),
    );
  }
}
