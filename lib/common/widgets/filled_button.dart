import 'package:flutter/material.dart';

class ButtonFilled extends StatelessWidget {
  const ButtonFilled({super.key, required this.text, this.onPressed});
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed ?? () {},
      style: ButtonStyle(
        backgroundColor:
            MaterialStatePropertyAll(Theme.of(context).primaryColor),
      ),
      child: Text(text),
    );
  }
}
