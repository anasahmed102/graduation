import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:real_estaye_app/core/lang/bloc/localaize_state.dart';
import 'package:real_estaye_app/core/lang/lang_cache_helper.dart';


class LocalizeCubit extends Cubit<ChangeLocaleState> {
  LocalizeCubit() : super(ChangeLocaleState(locale: const Locale('en')));
  Future<void> getSavedLanguage() async {
    final String cachedLanguageCode =
        await LanguageCacheHelper().getCachedLanguageCode();

    emit(ChangeLocaleState(locale: Locale(cachedLanguageCode)));
  }

  Future<void> changeLanguage(String languageCode) async {
    await LanguageCacheHelper().cacheLanguageCode(languageCode);
    emit(ChangeLocaleState(locale: Locale(languageCode)));
  }
}
