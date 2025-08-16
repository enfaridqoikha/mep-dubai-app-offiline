import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  bool _dark = false;
  MaterialColor _accent = Colors.blue;
  bool get isDark => _dark;
  MaterialColor get accent => _accent;

  void toggleDark() { _dark = !_dark; notifyListeners(); }
  void setAccent(MaterialColor c) { _accent = c; notifyListeners(); }

  ThemeData get light => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: _accent,
    brightness: Brightness.light,
    cardTheme: const CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
    ),
  );

  ThemeData get dark => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: _accent,
    brightness: Brightness.dark,
    cardTheme: const CardThemeData(
      elevation: 3,
      color: Color(0xFF111B2E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
    ),
  );

  ThemeData get theme => _dark ? dark : light;
}
