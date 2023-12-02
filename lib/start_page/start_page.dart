import 'package:flutter/material.dart';
import 'package:menukaran/common/constants.dart';
import 'package:menukaran/common/provider.dart';
import 'package:menukaran/common/route.dart' as route;
import 'package:menukaran/common/widgets/filled_button.dart';
import 'package:menukaran/common/widgets/header.dart';
import 'package:menukaran/start_page/action_menu.dart';
import 'package:menukaran/start_page/weather_icon.dart';
import 'package:provider/provider.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    context.read<ValueProvider>().getSavedOptions();
    super.initState();
  }

  @override
  void dispose() {
    context
        .read<ValueProvider>()
        .controllers
        .forEach((element) => element.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitleBar(
        title: Text(appTitle),
        leading: ActionMenu(),
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 200,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const WeatherIcon(),
              ButtonFilled(
                elevated: true,
                onPressed: () => Navigator.pushNamed(
                  context,
                  route.createDesktop,
                ),
                text: filledButton1,
              ),
              ButtonFilled(
                text: 'Show List',
                elevated: false,
                onPressed: () => setState(() {
                  Navigator.pushNamed(context, route.listPage);
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
