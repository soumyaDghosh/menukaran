import 'package:flutter/material.dart';
import 'package:menukaran/common/provider.dart';
import 'package:provider/provider.dart';

class TextFieldBar extends StatefulWidget {
  const TextFieldBar({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.textController,
    this.icon,
  });
  final String hintText;
  final String labelText;
  final TextEditingController textController;
  final Widget? icon;

  @override
  State<TextFieldBar> createState() => _TextFieldBarState();
}

class _TextFieldBarState extends State<TextFieldBar> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textController,
      decoration: InputDecoration(
        prefixIcon: widget.icon,
        hintText: widget.hintText,
        hintStyle: const TextStyle(height: 2),
        labelText: widget.labelText,
        labelStyle: const TextStyle(fontSize: 17),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelStyle: const TextStyle(
          fontSize: 20,
        ),
      ),
      style: const TextStyle(height: 2),
    );
  }
}
