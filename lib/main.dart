import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Localization',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // 我们需要在这里声明 app 所支持的所有语言
      supportedLocales: [
        Locale('en', 'US'), // 英文
        Locale('zh', 'CN'), // 中文
      ],
      // 这些委托是为了确保已加载正确语言的本地化数据
      localizationsDelegates: [
        // 从 json 文件中加载翻译文件的一个类
        AppLocalizations.delegate,
        // Material 小部件的基本文本的内置本地化
        // 就是我们平时使用的 Material Widget 的翻译，这是flutter已经内置的
        GlobalMaterialLocalizations.delegate,
        // 文本方向 LTR（从左到右） / RTL（从右到左） 的内置本地化
        GlobalWidgetsLocalizations.delegate,
      ],
      // 返回应用程序使用的语言环境
      localeResolutionCallback: (locale, supportedLocales) {
        // 检查是否当前设备支持这个语言
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        // 如果不支持，则直接使用第一门语言，在这里是英语
        return supportedLocales.first;
      },
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).translate('title'),
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                AppLocalizations.of(context).translate('content'),
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
