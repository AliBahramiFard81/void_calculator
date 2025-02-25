import 'package:flutter/material.dart';

class CustomTheme {
  final ThemeData themeData;
  CustomTheme({required this.themeData});
  static CustomTheme get dakTheme =>
      CustomTheme(themeData: ThemeData.dark(useMaterial3: true));
  static CustomTheme get lightTheme =>
      CustomTheme(themeData: ThemeData.light(useMaterial3: true));
}
