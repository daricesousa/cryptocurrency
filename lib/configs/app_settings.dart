import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  late SharedPreferences _prefs;
  // late Box box;

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
    // box = await Hive.openBox('settings');
  }

  void _readLocale() {
    locale = _prefs.getString('locale') ?? 'pt_BR';
    nameLocale = _prefs.getString('name') ?? 'R\$';
    // locale = box.get('locale') ?? 'pt_BR';
    // nameLocale = box.get('name') ?? 'R\$';
    notifyListeners();
  }

  Future<void> setLocale({required String locale, required String name}) async {
    await _prefs.setString('locale', locale);
    await _prefs.setString('name', name);
    // await box.put('locale', locale);
    // await box.put('name', name);
    _readLocale();
  }

  NumberFormat get numberFormat => NumberFormat.currency(
        locale: locale,
        name: nameLocale,
      );
}
