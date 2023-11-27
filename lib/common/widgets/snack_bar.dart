import 'package:flutter/material.dart';
import 'package:menukaran/common/widgets/timed_progress_indicator.dart';
import 'package:yaru/yaru.dart';

SnackBar snackBar(String text, GlobalKey<ScaffoldMessengerState> snackbarKey,
    {bool isClosable = true, int microseconds = 0, int seconds = 2}) {
  return SnackBar(
    content: Row(
      children: [
        Expanded(
          child: SelectableText(
            text,
            style: TextStyle(
              fontWeight: isMobile ? FontWeight.bold : null,
            ),
          ),
        ),
        if (isClosable)
          CustomCloseSnackBar(
            totalTime: seconds,
            snackbarKey: snackbarKey,
          )
      ],
    ),
    behavior: SnackBarBehavior.floating,
    duration: Duration(seconds: seconds, microseconds: microseconds),
  );
}
