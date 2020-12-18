import 'package:flutter/material.dart';
import 'package:github_flutter/common/localization/gsy_string_base.dart';
import 'package:github_flutter/common/localization/gsy_string_en.dart';
import 'package:github_flutter/common/localization/gsy_string_zh.dart';

/**
 * 多语言实现
 */

class GSYLocalizations {
  final Locale locale;

  GSYLocalizations(this.locale);

  static Map<String, GSYStringBase> _localizedValues = {
    'en': new GSYStringEn(),
    'zh': new GSYStringZh()
  };

  GSYStringBase get currentLocalized {
    if (_localizedValues.containsKey(locale.languageCode)) {
      return _localizedValues[locale.languageCode];
    }

    return _localizedValues['en'];
  }

  static GSYStringBase i18n(BuildContext context) {
    return (Localizations.of(context, GSYLocalizations) as GSYLocalizations)
        .currentLocalized;
  }
}
