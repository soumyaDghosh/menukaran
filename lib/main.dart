import 'package:flutter/material.dart';
import 'package:menukaran/common/provider.dart';
import 'package:menukaran/common/route.dart';
import 'package:provider/provider.dart';
import 'package:yaru/yaru.dart';

Future<void> main() async {
  await YaruWindowTitleBar.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => ValueProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final snackbarKey = context.read<ValueProvider>().snackbarKey;
    final navigatorKey = context.read<ValueProvider>().navigatorKey;
    final isSystemTheme =
        context.watch<ValueProvider>().optionsSelected.contains('theme1');
    final isdarkMode =
        context.watch<ValueProvider>().optionsSelected.contains('theme2');
    return YaruTheme(
      builder: (context, yaru, child) => MaterialApp(
        theme: isSystemTheme
            ? yaru.theme
            : isdarkMode
                ? yaru.darkTheme
                : yaru.theme,
        darkTheme: isSystemTheme
            ? yaru.darkTheme
            : isdarkMode
                ? yaru.darkTheme
                : yaru.theme,
        debugShowCheckedModeBanner: false,
        initialRoute: startPage,
        onGenerateRoute: routecontroller,
        scaffoldMessengerKey: snackbarKey,
        navigatorKey: navigatorKey,
      ),
    );
  }
}
