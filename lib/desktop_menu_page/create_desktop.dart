import 'dart:io';
// import 'package:file_picker/file_picker.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:menukaran/common/constants.dart';
import 'package:menukaran/common/provider.dart';
import 'package:menukaran/common/route.dart' as route;
import 'package:menukaran/common/widgets/filled_button.dart';
import 'package:menukaran/common/widgets/header.dart';
import 'package:menukaran/common/widgets/snack_bar.dart';
import 'package:menukaran/desktop_menu_page/choice_chip.dart';
import 'package:menukaran/desktop_menu_page/text_field_bar.dart';
import 'package:menukaran/models/desktop_model.dart';
import 'package:provider/provider.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class CreateDesktop extends StatefulWidget {
  final Desktop? desktop;
  const CreateDesktop({super.key, this.desktop});

  @override
  State<CreateDesktop> createState() => _CreateDesktopState();
}

class _CreateDesktopState extends State<CreateDesktop> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<ValueProvider>();
    final optionsSelected = provider.fieldsSelected;
    final snackbarKey = provider.snackbarKey;
    final navigatorKey = provider.navigatorKey;
    void showFilepicker() async {
      const XTypeGroup typeGroup = XTypeGroup(
        label: 'images',
        extensions: <String>['jpg', 'png'],
      );
      final XFile? path =
          await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);

      if (path != null) {
        setState(() {
          context.read<ValueProvider>().iconPath(path.path);
        });
        return;
      } else {
        snackbarKey.currentState
            ?.showSnackBar(snackBar('Cancelled!', snackbarKey));
      }
    }

    void nullicon() {
      setState(() {
        context.read<ValueProvider>().iconPath('');
      });
    }

    return Scaffold(
      appBar: TitleBar(
        leading: YaruBackButton(
          onPressed: () {
            context.read<ValueProvider>().clearControllers();
            Navigator.maybePop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 64,
                  backgroundImage: context.read<ValueProvider>().icon == null ||
                          context.read<ValueProvider>().icon!.isEmpty
                      ? null
                      : FileImage(File(context.read<ValueProvider>().icon!)),
                  child: context.read<ValueProvider>().icon == null ||
                          context.read<ValueProvider>().icon!.isEmpty
                      ? const YaruPlaceholderIcon(size: Size(128, 128))
                      : null,
                ),
                Positioned(
                  right: 1,
                  bottom: 1,
                  child: YaruIconButton(
                    onPressed: () {
                      context.read<ValueProvider>().icon == null ||
                              context.read<ValueProvider>().icon!.isEmpty
                          ? showFilepicker()
                          : nullicon();
                    },
                    icon: context.read<ValueProvider>().icon == null ||
                            context.read<ValueProvider>().icon!.isEmpty
                        ? const Icon(
                            Icons.add_a_photo,
                            size: kYaruIconSize * 1.15,
                          )
                        : const Icon(
                            Icons.delete,
                            color: Color.fromARGB(255, 138, 107, 105),
                            size: kYaruIconSize * 1.5,
                          ),
                  ),
                ),
                // if (context.read<ValueProvider>().icon.isEmpty)
                //   Positioned(
                //     right: 1,
                //     bottom: 1,
                //     child: YaruIconButton(
                //       icon: const Icon(Icons.add_a_photo_rounded),
                //       onPressed: () async {
                //         FilePickerResult? path =
                //             await FilePicker.platform.pickFiles();
                //         if (path != null) {
                //           setState(() {
                //             context
                //                 .read<ValueProvider>()
                //                 .iconPath(path.files.single.path!);
                //           });
                //           return;
                //         } else {
                //           snackbarKey.currentState?.showSnackBar(
                //               snackBar('Cancelled!', snackbarKey));
                //         }
                //       },
                //     ),
                //   ),
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
                        icon: Icon(fields.value.$4),
                        hintText: fields.value.$2,
                        labelText: fields.value.$1,
                        textController: context
                            .read<ValueProvider>()
                            .controllers[fields.value.$3 - 1],
                      ),
                    ),
                  for (final extraField in extraDesktopFields.entries)
                    if (optionsSelected.contains(extraField.key))
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 40,
                          bottom: 20,
                          right: 40,
                          top: 20,
                        ),
                        child: TextFieldBar(
                          hintText: extraField.value.$2,
                          labelText: extraField.value.$1,
                          icon: Icon(extraField.value.$4),
                          textController: context
                              .read<ValueProvider>()
                              .extraControllers[extraField.value.$3 - 1],
                        ),
                      ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 40, right: 40, bottom: 20),
            child: ChoiceChipBar(),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 40,
            ),
            child: ButtonFilled(
              elevated: false,
              text: widget.desktop != null ? 'Update' : 'Create',
              onPressed: () async {
                for (int i = 0; i <= 1; i++) {
                  if (context
                      .read<ValueProvider>()
                      .controllers[i]
                      .text
                      .isEmpty) {
                    snackbarKey.currentState?.showSnackBar(
                      snackBar(
                          errorMessages[0] +
                              desktopFields.entries.elementAt(i).value.$1,
                          snackbarKey),
                    );
                    return;
                  }
                }
                try {
                  String fileName =
                      '${context.read<ValueProvider>().controllers[0].text.toLowerCase()}.desktop';
                  final result = await getSaveLocation(
                    suggestedName: fileName,
                    initialDirectory:
                        '/home/$userName/.local/share/applications',
                  );
                  if (result == null) {
                    snackbarKey.currentState?.hideCurrentSnackBar();
                    snackbarKey.currentState
                        ?.showSnackBar(snackBar(installhelp[1], snackbarKey));
                    return;
                  }
                  provider.installdesktop(result.path, widget.desktop);
                } catch (e) {
                  provider.setMessage(e.toString());
                  navigatorKey.currentState?.pushNamed(route.failedtoCopy);
                  // snackbarKey.currentState
                  //     ?.showSnackBar(snackBar(e.toString(), snackbarKey));
                  return;
                }
                navigatorKey.currentState?.pushNamed(route.desktopCopied);
              },
            ),
          ),
        ],
      ),
    );
  }
}
