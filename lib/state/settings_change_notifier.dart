import 'package:flutter/material.dart';

class SettingsChangeNotifier extends ChangeNotifier {
  bool _autosave = false;

  set autosave(bool value) {
    _autosave = value;
    notifyListeners();
  }

  bool get autosave => _autosave;
}
