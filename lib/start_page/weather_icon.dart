import 'package:flutter/material.dart';
import 'package:menukaran/common/constants.dart';

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconMap[TimeOfDay.now()]?.$1,
      size: 150,
    );
  }
}
