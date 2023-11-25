import 'package:flutter/material.dart';
import 'package:menukaran/common/provider.dart';
import 'package:menukaran/common/route.dart';
import 'package:provider/provider.dart';
import 'package:yaru/yaru.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

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
    return YaruTheme(
      builder: (context, yaru, child) => MaterialApp(
        theme: yaru.theme,
        darkTheme: yaru.darkTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: startPage,
        onGenerateRoute: routecontroller,
      ),
    );
  }
}
