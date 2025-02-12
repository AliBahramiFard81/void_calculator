import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  final ThemeData themeData;
  CustomTheme({required this.themeData});
  static CustomTheme get dakTheme => CustomTheme(
    themeData: FlexThemeData.dark(scheme: FlexScheme.blue, useMaterial3: true),
  );
  static CustomTheme get lightTheme => CustomTheme(
    themeData: FlexThemeData.light(scheme: FlexScheme.blue, useMaterial3: true),
  );
}
