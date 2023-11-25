import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:menukaran/common/constants.dart';
import 'package:menukaran/common/provider.dart';
import 'package:menukaran/common/route.dart' as route;
import 'package:menukaran/common/widgets/filled_button.dart';
import 'package:menukaran/common/widgets/header.dart';
import 'package:menukaran/desktop_menu_page/text_field_bar.dart';
import 'package:provider/provider.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class CreateDesktop extends StatefulWidget {
  const CreateDesktop({super.key});

  @override
  State<CreateDesktop> createState() => _CreateDesktopState();
}

class _CreateDesktopState extends State<CreateDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitleBar(
        leading: YaruBackButton(),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 64,
                  child: context.read<ValueProvider>().icon.isNotEmpty
                      ? Image.file(File(context.read<ValueProvider>().icon))
                      : const YaruPlaceholderIcon(size: Size(128, 128)),
                ),
                Positioned(
                  right: 1,
                  bottom: 1,
                  child: YaruIconButton(
                    icon: const Icon(Icons.add_a_photo),
                    onPressed: () async {
                      FilePickerResult? path =
                          await FilePicker.platform.pickFiles();
                      if (path != null) {
                        setState(() {
                          context
                              .read<ValueProvider>()
                              .iconPath(path.files.single.path!);
                        });
                      } else {
                        print('Cancelled');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (final fields in desktopFields.entries)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 40,
                        bottom: 20,
                        right: 40,
                        top: 20,
                      ),
                      child: TextFieldBar(
                        hintText: fields.value.$2,
                        labelText: fields.value.$1,
                        index: fields.value.$3 - 1,
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 40,
            ),
            child: ButtonFilled(
              text: 'Create',
              onPressed: () {
                context.read<ValueProvider>().installdesktop();
                context.read<ValueProvider>().clearControllers();
                Navigator.pushNamed(context, route.desktopCopied);
              },
            ),
          ),
        ],
      ),
    );
  }
}
