import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isDark() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('is_dark') ?? false;
}

Future<bool> setTheme(bool isDark) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setBool('is_dark', !isDark);
}
