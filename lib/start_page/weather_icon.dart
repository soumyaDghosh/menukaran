import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:menukaran/common/constants.dart';

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final iconMap = <TimeOfDay, (IconData, String)>{
      if (DateTime.now().hour >= 6 && DateTime.now().hour < 12)
        TimeOfDay.now(): (FeatherIcons.sunrise, 'Good Morning'),
      if (DateTime.now().hour >= 12 && DateTime.now().hour < 18)
        TimeOfDay.now(): (FeatherIcons.sun, 'Good Day'),
      if (DateTime.now().hour >= 18 && DateTime.now().hour < 21)
        TimeOfDay.now(): (FeatherIcons.sunset, 'Good Evening'),
      if (DateTime.now().hour >= 21 && DateTime.now().hour < 24)
        TimeOfDay.now(): (FeatherIcons.moon, 'Good Night'),
      if (DateTime.now().hour >= 0 && DateTime.now().hour < 6)
        TimeOfDay.now(): (FeatherIcons.moon, 'Good Night'),
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
        Icon(
          iconMap[TimeOfDay.now()]?.$1,
          size: 150,
        ),
      ],
    );
  }
}
