import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization {
  final Locale? locale;

  AppLocalization({this.locale});

  static AppLocalization? of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  static const LocalizationsDelegate<AppLocalization> delegate =
      _AppLocalizationDelegate();

  late Map<String, String> _localizedStrings;

  Future loadJsonLanguage() async {
    String jsonString =
        await rootBundle.loadString("assets/lang/${locale!.languageCode}.json");

    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }

  String transalte(String key) => _localizedStrings[key] ?? "";
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar', 'ku'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization loclization = AppLocalization(locale: locale);
    await loclization.loadJsonLanguage();
    return loclization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) =>
      false;
}

extension TranslateX on String {
  String tr(BuildContext context) {
    return AppLocalization.of(context)!.transalte(this);
  }
}
