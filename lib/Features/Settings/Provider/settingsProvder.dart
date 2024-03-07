import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  static const String backgroundMusicKey = 'backgroundMusic';

  bool _backgroundMusicEnabled = true;

  bool get backgroundMusicEnabled => _backgroundMusicEnabled;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _backgroundMusicEnabled = prefs.getBool(backgroundMusicKey) ?? true;
    notifyListeners();
  }

  Future<void> setBackgroundMusicSetting(bool value) async {
    _backgroundMusicEnabled = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(backgroundMusicKey, value);
    notifyListeners();
  }
}
