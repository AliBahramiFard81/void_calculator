part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

final class InitialThemeSetEvent extends ThemeEvent {}

final class ThemeSwitchEvent extends ThemeEvent {
  final BuildContext context;
  ThemeSwitchEvent({required this.context});
}
