import 'package:flutter/material.dart';

class ButtonFilled extends StatelessWidget {
  const ButtonFilled(
      {super.key, required this.text, this.onPressed, required this.elevated});
  final String text;
  final VoidCallback? onPressed;
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    return elevated
        ? ElevatedButton(
            onPressed: onPressed ?? () {},
            child: Text(text),
          )
        : FilledButton(
            onPressed: onPressed ?? () {},
            child: Text(text),
          );
  }
}
