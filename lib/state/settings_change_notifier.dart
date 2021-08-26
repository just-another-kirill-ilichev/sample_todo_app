import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsChangeNotifier extends ChangeNotifier {
  final SharedPreferences preferences;

  late bool _autosave;
  late String _locale;

  set autosave(bool value) {
    _autosave = value;
    preferences.setBool('autosave', _autosave);
    notifyListeners();
  }

  bool get autosave => _autosave;

  String get locale => _locale;

  SettingsChangeNotifier(this.preferences) {
    _autosave = preferences.getBool('autosave') ?? false;
    _locale = preferences.getString('locale') ?? 'ru_RU';
  }
}
