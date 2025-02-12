import 'package:bloc/bloc.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:main/themes/theme.dart';
import 'package:main/themes/theme_helper.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  ThemeBloc() : super(FlexThemeData.light()) {
    on<InitialThemeSetEvent>((event, emit) async {
      final bool isDarkMode = await isDark();
      if (isDarkMode) {
        emit(CustomTheme.dakTheme.themeData);
      } else {
        emit(CustomTheme.lightTheme.themeData);
      }
    });

    on<ThemeSwitchEvent>((event, emit) {
      final isDark = Theme.of(event.context).brightness == Brightness.dark;
      emit(
        isDark
            ? CustomTheme.lightTheme.themeData
            : CustomTheme.dakTheme.themeData,
      );
      setTheme(isDark);
    });
  }
}
