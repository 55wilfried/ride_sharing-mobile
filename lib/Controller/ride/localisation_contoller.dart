import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

///
/// This class provides localization support by loading localized strings from JSON files.
/// Author: Ictu3091081
/// Created at: September 2024
///
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  /// Provides access to the [AppLocalizations] instance from the [BuildContext].
  ///
  /// [context] The [BuildContext] used to retrieve the localizations.
  /// Returns an [AppLocalizations] instance or `null` if it cannot be found.
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  late Map<String, String> _localizedStrings;

  /// Loads the localized strings from a JSON file.
  ///
  /// Reads the JSON file corresponding to the current locale and parses it.
  /// Returns a [Future<bool>] indicating whether the load was successful.
  Future<bool> load() async {
    // Load the JSON string from the asset
    String jsonString = await rootBundle.loadString('assets/languages/${locale.languageCode}.json');

    // Decode the JSON string
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    // Convert the JSON map to a map of string key-value pairs
    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
    return true;
  }

  /// Translates a key into its corresponding localized string.
  ///
  /// [key] The key for the localized string.
  /// Returns the localized string or the key if no translation is found.
  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}

///
/// This delegate provides an [AppLocalizations] instance for the given locale.
/// Author: Ictu3091081
/// Created at: September 2024
///
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // Create an instance of AppLocalizations and load the localized strings
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
