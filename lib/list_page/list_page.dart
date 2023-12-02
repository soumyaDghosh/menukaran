import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:icon_animated/icon_animated.dart';
import 'package:menukaran/common/constants.dart';
import 'package:menukaran/common/provider.dart';
import 'package:menukaran/common/route.dart' as route;
import 'package:menukaran/common/widgets/filled_button.dart';
import 'package:menukaran/common/widgets/snack_bar.dart';
import 'package:menukaran/desktop_menu_page/create_desktop.dart';
import 'package:menukaran/models/desktop_model.dart';
import 'package:menukaran/services/database_helper.dart';
import 'package:provider/provider.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class ListDesktops extends StatefulWidget {
  const ListDesktops({super.key});

  @override
  State<ListDesktops> createState() => _ListDesktopsState();
}

class _ListDesktopsState extends State<ListDesktops> {
  @override
  void initState() {
    context.read<ValueProvider>().controllers;
    super.initState();
  }

  Desktop? desktop;
  @override
  Widget build(BuildContext context) {
    final snackbarKey = context.read<ValueProvider>().snackbarKey;
    bool lightmode = Brightness.light == Theme.of(context).brightness;
    return Scaffold(
        appBar: const YaruWindowTitleBar(
          leading: YaruBackButton(),
          border: BorderSide.none,
          backgroundColor: Colors.transparent,
        ),
        body: FutureBuilder<List<Desktop>?>(
          future: DataBaseHelper.getAllDesktop(),
          builder: (context, AsyncSnapshot<List<Desktop>?> snapshot) {
            print(DataBaseHelper.getAllDesktop());
            print(snapshot.data);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: YaruCircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.hasData) {
                if (snapshot.data != null) {
                  return ListView.builder(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(20),
                      child: YaruSection(
                        headline: Text(
                            '${snapshot.data![index].id.toString()}.\t${snapshot.data![index].name}'),
                        headlinePadding:
                            const EdgeInsets.only(top: 8, bottom: 8, left: 40),
                        padding: EdgeInsets.zero,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 64,
                            backgroundImage: snapshot.data![index].icon ==
                                        null ||
                                    snapshot.data![index].icon!.isEmpty
                                ? null
                                : FileImage(File(snapshot.data![index].icon!)),
                            child: snapshot.data![index].icon == null ||
                                    snapshot.data![index].icon!.isEmpty
                                ? const YaruPlaceholderIcon(size: Size(50, 50))
                                : null,
                          ),
                          title: Text(snapshot.data![index].filename),
                          subtitle: Text('${snapshot.data![index].executable}'),
                          trailing: YaruIconButton(
                            icon: const Icon(YaruIcons.trash),
                            onPressed: () async {
                              const XTypeGroup typeGroup = XTypeGroup(
                                label: 'desktop',
                                extensions: <String>['desktop'],
                              );
                              final XFile? deletingPath = await openFile(
                                acceptedTypeGroups: <XTypeGroup>[typeGroup],
                                initialDirectory:
                                    '$home/.local/share/applications',
                                confirmButtonText:
                                    'Select ${snapshot.data![index].filename}',
                              );
                              if (deletingPath != null) {
                                File(deletingPath.path).deleteSync();
                              } else {
                                snackbarKey.currentState?.showSnackBar(
                                    snackBar('Cancelled!', snackbarKey));
                                return;
                              }
                              setState(() {
                                DataBaseHelper.deleteDesktop(
                                    snapshot.data![index]);
                              });
                            },
                          ),
                          onTap: () {
                            final controllers =
                                context.read<ValueProvider>().controllers;
                            controllers[0].text = snapshot.data![index].name;
                            controllers[1].text =
                                snapshot.data![index].executable;
                            context
                                .read<ValueProvider>()
                                .iconPath(snapshot.data![index].icon ?? '');
                            context.read<ValueProvider>().type =
                                snapshot.data![index].type;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateDesktop(
                                  desktop: snapshot.data![index],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                }
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Nothing to show',
                      style: TextStyle(fontSize: 20),
                    ),
                    IconAnimated(
                      active: true,
                      size: 400,
                      iconType: IconType.alert,
                      color: lightmode ? Colors.blueGrey[800] : Colors.blueGrey,
                    ),
                    ButtonFilled(
                      onPressed: () =>
                          Navigator.pushNamed(context, route.createDesktop),
                      text: filledButton1,
                      elevated: true,
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }
}
