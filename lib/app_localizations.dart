import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  // 静态成员可以从 MaterialApp 轻松访问委托
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    // 从“ lang”文件夹加载语言JSON文件
    String jsonString =
        await rootBundle.loadString('lang/${locale.languageCode}.json');
    // 生成映射
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  // 每个需要翻译的文本小部件都将调用此方法
  String translate(String key) {
    return _localizedStrings[key];
  }
}

// LocalizationsDelegate 是一组本地化资源的工厂
// 在这里，本地化的字符串将在 AppLocalizations 对象中获取
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  // 构造函数
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // 在此处包括所有支持的语言代码
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // 在这里我们就要调用主逻辑了
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
