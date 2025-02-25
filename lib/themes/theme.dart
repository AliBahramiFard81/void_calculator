import 'package:flutter/material.dart';
import 'package:main/common/colors.dart';

class CustomTheme {
  final ThemeData themeData;
  CustomTheme({required this.themeData});
  static CustomTheme get dakTheme => CustomTheme(
    themeData: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark().copyWith(primary: nothingRedColor),
    ),
  );
  static CustomTheme get lightTheme => CustomTheme(
    themeData: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light().copyWith(primary: nothingRedColor),
    ),
  );
}
