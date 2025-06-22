import 'package:flutter/material.dart';
import 'package:menukaran/common/constants.dart';
import 'package:menukaran/common/provider.dart';
import 'package:provider/provider.dart';
import 'package:yaru/yaru.dart';

class ChoiceChipBar extends StatefulWidget {
  const ChoiceChipBar({super.key});

  @override
  State<ChoiceChipBar> createState() => _ChoiceChipBarState();
}

class _ChoiceChipBarState extends State<ChoiceChipBar> {
  @override
  Widget build(BuildContext context) {
    void onSelect(String value) {
      context.read<ValueProvider>().setType(value);
    }

    return YaruChoiceChipBar(
      labels: List.generate(types.length, (index) => Text(types[index])),
      isSelected: List.generate(
        types.length,
        (index) => context.read<ValueProvider>().type.contains(types[index]),
      ),
      onSelected: (index) => setState(() {
        onSelect(types[index]);
      }),
    );
  }
}
