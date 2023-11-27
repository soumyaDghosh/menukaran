import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class TimedCircularProgressIndicator extends StatefulWidget {
  final int totalTime;
  final double initialValue;

  const TimedCircularProgressIndicator({
    required this.totalTime,
    this.initialValue = 0.0,
    super.key,
  });

  @override
  State<TimedCircularProgressIndicator> createState() =>
      _TimedCircularProgressIndicatorState();
}

class _TimedCircularProgressIndicatorState
    extends State<TimedCircularProgressIndicator> {
  late Timer _timer;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _progress = widget.initialValue;
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      _progress += 1 / (widget.totalTime * 10);
      if (_progress >= widget.totalTime) {
        timer.cancel();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YaruCircularProgressIndicator(
      value: _progress,
    );
  }
}

class CustomCloseSnackBar extends StatelessWidget {
  const CustomCloseSnackBar({
    super.key,
    required this.totalTime,
    required this.snackbarKey,
  });
  final int totalTime;
  final GlobalKey<ScaffoldMessengerState> snackbarKey;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TimedCircularProgressIndicator(totalTime: totalTime),
        Positioned(
          top: 0,
          right: 1,
          child: YaruIconButton(
            onPressed: () => snackbarKey.currentState?.hideCurrentSnackBar(),
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
