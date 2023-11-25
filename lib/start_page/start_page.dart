import 'package:flutter/material.dart';
import 'package:menukaran/common/constants.dart';
import 'package:menukaran/common/provider.dart';
import 'package:menukaran/common/route.dart' as route;
import 'package:menukaran/common/widgets/filled_button.dart';
import 'package:menukaran/common/widgets/header.dart';
import 'package:menukaran/start_page/weather_icon.dart';
import 'package:provider/provider.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
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
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100, bottom: 100),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const WeatherIcon(),
              Text(
                greeting,
                style: const TextStyle(fontSize: 15),
              ),
              ButtonFilled(
                onPressed: () => Navigator.pushNamed(
                  context,
                  route.createDesktop,
                ),
                text: filledButton1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
