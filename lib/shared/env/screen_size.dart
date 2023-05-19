import 'package:flutter/material.dart';

class ScreenSize {
  final double width;
  final double height;

  ScreenSize({required this.width, required this.height});

  static ScreenSize getScreenSize(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double height = mediaQuery.size.height;
    final double width = mediaQuery.size.width;
    return ScreenSize(width: width, height: height);
  }
}
