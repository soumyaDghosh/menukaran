import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:menukaran/common/constants.dart';
import 'package:menukaran/start_page/weather_icon.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YaruWindowTitleBar(
        title: Text(appTitle),
        style: YaruTitleBarStyle.normal,
        border: BorderSide.none,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100, bottom: 100),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                iconMap[TimeOfDay.now()]?.$2 ?? 'Welcome',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const WeatherIcon(),
              Text(
                greeting,
                style: const TextStyle(fontSize: 15),
              ),
              FilledButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Theme.of(context).primaryColor),
                ),
                onPressed: () {},
                child: const Text(filledButton1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
