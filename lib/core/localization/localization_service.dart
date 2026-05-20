import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';

class LocalizationService extends GetxService {
  late Map<String, String> _localizedStrings;
  final Rx<Locale> _locale = const Locale('en').obs;

  Locale get locale => _locale.value;

  Future<LocalizationService> init() async {
    await _loadLocalizedStrings(locale);
    return this;
  }

  Future<void> _loadLocalizedStrings(Locale locale) async {
    String jsonString = await rootBundle.loadString('lib/l10n/intl_${locale.languageCode}.arb');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }

  Future<void> changeLocale(Locale newLocale) async {
    _locale.value = newLocale;
    await _loadLocalizedStrings(newLocale);
    Get.updateLocale(newLocale);
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}
