import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  late SharedPreferences _prefs;

  String locale = 'pt_BR';
  String nameLocale = 'R\$';

  AppSettings() {
    _startSettings();
  }

  Future<void> _startSettings() async {
    await _startPreferences();
    _readLocale();
  }

  Future<void> _startPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void _readLocale() {
    locale = _prefs.getString('locale') ?? 'pt_BR';
    nameLocale = _prefs.getString('name') ?? 'R\$';
    notifyListeners();
  }

  Future<void> setLocale({required String locale, required String name}) async {
    await _prefs.setString('locale', locale);
    await _prefs.setString('name', name);
    _readLocale();
  }
}
