import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:meals/constants.dart';

/// Service class dealing with all things theme related.
///
///   1 = light and 2 = dark while saving the theme to box.
///
class ThemeService extends GetxController {
  final _themeBox = Hive.box(themeDbName);

  @override
  void onInit() {
    _populateTheme();
    super.onInit();
  }

  /// Method to populate the theme mode data in _currentThemeMode variable after getting it from hive box.
  _populateTheme() async {
    /// Getting the saved value from the box.
    int? saved = _themeBox.get(themeSaveKey);

    // Nothing is saved to box yet, so defaulting the theme to light
    if (saved == null) {
      _currentThemeMode.value = ThemeMode.light;
    } else {
      // 1 = light.
      if (saved == 1) {
        _currentThemeMode.value = ThemeMode.light;
      }
      // anything else than 1 = dark.
      else {
        _currentThemeMode.value = ThemeMode.dark;
      }
    }
  }

  late final Rx<ThemeMode> _currentThemeMode = ThemeMode.light.obs;

  // Getter to get current theme mode.
  ThemeMode get currentThemeMode => _currentThemeMode.value;

  /// Function to save user selected theme mode to box.
  Future<void> setCurrentThemeMode(ThemeMode mode) async {
    // updating variable.
    _currentThemeMode.value = mode;
    // storing to box.
    await _themeBox.put(themeSaveKey, mode == ThemeMode.light ? 1 : 2);
    Get.changeTheme(mode == ThemeMode.dark ? darkModeData : lightModeData);
    update();
  }

  /// Getter to get light theme mode theme data.
  ThemeData get lightModeData => _lightTheme;

  /// Getter to get dark theme mode theme data.
  ThemeData get darkModeData => _darkTheme;

  final ThemeData _lightTheme = ThemeData(
    primaryColor: const Color(0xFF302F4D),
    primaryColorLight: const Color(0xFF302F4D),
    backgroundColor: Colors.white,
    highlightColor: const Color(0xFF98c1d9),
    // // ignore: deprecated_member_use
    // buttonColor: const Color(0xFF3d5a80),
    colorScheme: const ColorScheme.light(
      secondary: Colors.black,
    ),
  );

  final ThemeData _darkTheme = ThemeData(
    primaryColor: const Color(0xFF302F4D),
    primaryColorLight: Colors.white,
    backgroundColor: const Color(0xFF120D31),
    colorScheme: const ColorScheme.dark(
      secondary: Colors.white,
    ),
    highlightColor: const Color(0xFF98c1d9),
    // // ignore: deprecated_member_use
    // buttonColor: const Color(0xFF3d5a80),
  );
}
