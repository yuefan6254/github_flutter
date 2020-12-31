import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:github_flutter/common/localization/localizations.dart';

/**
 * 多语言代理
 */

class GSYLocalizationsDelege extends LocalizationsDelegate<GSYLocalizations> {
  GSYLocalizationsDelege();

  bool isSupported(Locale locale) {
    return true;
  }

  bool shouldReload(LocalizationsDelegate<GSYLocalizations> old) {
    return false;
  }

  Future<GSYLocalizations> load(Locale locale) {
    return new SynchronousFuture<GSYLocalizations>(
        new GSYLocalizations(locale));
  }

  // 全局静态代理
  static GSYLocalizationsDelege delegate = new GSYLocalizationsDelege();
}
