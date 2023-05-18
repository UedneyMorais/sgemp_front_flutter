import 'package:flutter/material.dart';

class SnackbarWidget {
  static showSnackBar(BuildContext context,
      {required String text, required int duration}) {
    return ScaffoldMessenger.maybeOf(context)!.showSnackBar(
      SnackBar(
        duration: Duration(seconds: duration),
        content: Text(text == '' ? '' : text),
      ),
    );
  }
}
