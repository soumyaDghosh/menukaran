import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:menukaran/common/constants.dart';

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final iconMap = <TimeOfDay, (String, String)>{
      if (DateTime.now().hour >= 5 && DateTime.now().hour < 8)
        TimeOfDay.now(): ('assets/sun_rise.json', 'Good Morning'),
      if (DateTime.now().hour >= 8 && DateTime.now().hour < 18)
        TimeOfDay.now(): ('assets/sun_day.json', 'Good Day'),
      if (DateTime.now().hour >= 18 && DateTime.now().hour < 20)
        TimeOfDay.now(): ('assets/moon_rise.json', 'Good Evening'),
      if (DateTime.now().hour >= 20 && DateTime.now().hour < 24)
        TimeOfDay.now(): ('assets/moon_night.json', 'Good Night'),
      if (DateTime.now().hour >= 0 && DateTime.now().hour < 5)
        TimeOfDay.now(): ('assets/moon_night.json', 'Good Night'),
    };
    return Column(
      children: [
        Text(
          iconMap[TimeOfDay.now()]?.$2 ?? 'Welcome',
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        Lottie.asset(
          iconMap[TimeOfDay.now()]!.$1,
          height: 150,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
          child: Text(
            greeting,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
