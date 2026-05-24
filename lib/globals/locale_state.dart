import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/i18n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

@NowaGenerated()
class LocaleState extends ChangeNotifier {
  LocaleState() {
    Future<void> _loadLocale() async {
      final prefs = await SharedPreferences.getInstance();
      final code = prefs.getString('locale');
      if (code != null && code.isNotEmpty) {
        _setLocaleInternal(Locale(code));
      } else {
        _setLocaleInternal(AppLocalizations.supportedLocales.first);
      }
    }

    _loadLocale();
    setLocale(const Locale('fr'));
  }

  factory LocaleState.of(BuildContext context, {bool listen = true}) {
    return Provider.of<LocaleState>(context, listen: listen);
  }

  Locale? locale;

  AppLocalizations _currentLocalizations = AppLocalizations.getByLocale(
    AppLocalizations.supportedLocales.first,
  );

  AppLocalizations get l10n {
    return _currentLocalizations;
  }

  static List<Locale> get supportedLocales {
    return AppLocalizations.supportedLocales;
  }

  Future<void> setLocale(Locale? looc) async {
    if (looc == locale) {
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    if (looc == null) {
      await prefs.remove('locale');
      _setLocaleInternal(AppLocalizations.supportedLocales.first);
    } else {
      await prefs.setString('locale', looc.languageCode);
      _setLocaleInternal(looc);
    }
  }

  void _setLocaleInternal(Locale looc) {
    locale = looc;
    _currentLocalizations = AppLocalizations.getByLocale(looc);
    notifyListeners();
  }
}
