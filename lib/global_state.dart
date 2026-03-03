import 'package:flutter/material.dart';
import 'package:railmates/i18n/app_localizations.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

@NowaGenerated()
class GlobalState extends ChangeNotifier {
  GlobalState() {
    _loadLocale();
    setLocale(const Locale('fr'));
  }

  factory GlobalState.of(BuildContext context, {bool listen = true}) {
    return Provider.of<GlobalState>(context, listen: listen);
  }

  Locale? _locale;

  AppLocalizations _currentLocalizations = AppLocalizations.getByLocale(
    AppLocalizations.supportedLocales.first,
  );

  AppLocalizations get localizations {
    return _currentLocalizations;
  }

  Locale? get locale {
    return _locale;
  }

  static List<Locale> get supportedLocales {
    return AppLocalizations.supportedLocales;
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('locale');
    if (code != null && code!.isNotEmpty) {
      _setLocaleInternal(Locale(code));
    } else {
      _setLocaleInternal(AppLocalizations.supportedLocales.first);
    }
  }

  Future<void> setLocale(Locale? locale) async {
    if (locale == _locale) {
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    if (locale == null) {
      await prefs.remove('locale');
      _setLocaleInternal(AppLocalizations.supportedLocales.first);
    } else {
      await prefs.setString('locale', locale.languageCode);
      _setLocaleInternal(locale);
    }
  }

  void _setLocaleInternal(Locale locale) {
    _locale = locale;
    _currentLocalizations = AppLocalizations.getByLocale(locale);
    notifyListeners();
  }
}
