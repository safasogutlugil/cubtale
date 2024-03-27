import 'package:flutter/material.dart';

class ThemeState {
  final ThemeData themeData;

  ThemeState({required this.themeData});

  bool get isDarkMode => themeData.brightness == Brightness.dark;
}
