import 'package:basic_english/blocs/theme/theme_state.dart';
import 'package:basic_english/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static bool isDark = false;
  static bool useDeviceTheme = true;

  static Future<void> setTheme(
      {required bool useDeviceTheme, required bool isDark}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('useDeviceTheme', useDeviceTheme);
    await prefs.setBool('isDark', isDark);
  }

  static Future<void> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    useDeviceTheme = prefs.getBool('useDeviceTheme') ?? true;
    isDark = prefs.getBool('isDark') ?? false;
  }

  static CupertinoThemeData buildTheme(ThemeState state) {
    return CupertinoThemeData(
      brightness: state.isDark ? Brightness.dark : Brightness.light,
      primaryColor: CupertinoColors.systemBlue,
      barBackgroundColor: const CupertinoDynamicColor.withBrightness(
        color: CupertinoColors.lightBackgroundGray,
        darkColor: CupertinoColors.darkBackgroundGray,
      ),
      scaffoldBackgroundColor: CupertinoDynamicColor.withBrightness(
        color: ColorConstants.lightBackground,
        darkColor: ColorConstants.darkBackground,
      ),
      textTheme: const CupertinoTextThemeData(
        primaryColor: CupertinoDynamicColor.withBrightness(
          color: CupertinoColors.black,
          darkColor: CupertinoColors.white,
        ),
        textStyle: TextStyle(
          color: CupertinoDynamicColor.withBrightness(
            color: CupertinoColors.black,
            darkColor: CupertinoColors.white,
          ),
        ),
      ),
    );
  }
}
