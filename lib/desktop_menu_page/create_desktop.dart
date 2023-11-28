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
    final snackbarKey = context.read<ValueProvider>().snackbarKey;
    final navigatorKey = context.read<ValueProvider>().navigatorKey;
    String fileName =
        '${context.read<ValueProvider>().controllers[0].text}.desktop';
    // void showFilepicker() async {
    //   FilePickerResult? path =
    //       await FilePicker.platform.pickFiles(type: FileType.image);
    //   if (path != null) {
    //     setState(() {
    //       context.read<ValueProvider>().iconPath(path.files.single.path!);
    //     });
    //     return;
    //   } else {
    //     snackbarKey.currentState
    //         ?.showSnackBar(snackBar('Cancelled!', snackbarKey));
    //   }
    // }

    void nullicon() {
      setState(() {
        context.read<ValueProvider>().iconPath('');
      });
    }

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
                  backgroundImage: context.read<ValueProvider>().icon.isNotEmpty
                      ? FileImage(File(context.read<ValueProvider>().icon))
                      : null,
                  child: context.read<ValueProvider>().icon.isNotEmpty
                      ? null
                      : const YaruPlaceholderIcon(size: Size(128, 128)),
                ),
                Positioned(
                  right: 1,
                  bottom: 1,
                  child: YaruIconButton(
                    onPressed: () {
                      context.read<ValueProvider>().icon.isEmpty
                          ? null // ? showFilepicker()
                          : nullicon();
                    },
                    icon: context.read<ValueProvider>().icon.isEmpty
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
                        hintText: fields.value.$2,
                        labelText: fields.value.$1,
                        index: fields.value.$3 - 1,
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
              text: 'Create',
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
                  print(fileName);
                  print(result.path.toString());
                  await context
                      .read<ValueProvider>()
                      .installdesktop(result.path.toString(), fileName);
                } catch (e) {
                  context.read<ValueProvider>().setMessage(e.toString());
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
