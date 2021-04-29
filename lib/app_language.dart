import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = Locale('en');

  Locale get appLocal => _appLocale ?? Locale("en");

  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('language_code')) {
      _appLocale = Locale('en');
    }
    _appLocale = Locale(prefs.getString('language_code'));
  }

  void changeLanguage(Locale locale) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == locale) {
      return;
    }
    if (locale == Locale("el")) {
      _appLocale = Locale("el");
      await prefs.setString('language_code', 'el');
      await prefs.setString('countryCode', 'GR');
    } else {
      _appLocale = Locale('en');
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }
    notifyListeners();
  }
}
