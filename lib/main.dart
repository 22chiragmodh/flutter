import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodcafe/src/features/translations.dart';
import 'package:foodcafe/src/screens/home_screen.dart';
import 'package:foodcafe/src/screens/main_screen.dart';
import 'package:foodcafe/src/screens/menu_screen.dart';
import 'package:foodcafe/src/utils/color.dart';
import 'package:get/get.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: MenuContainer.background,
    statusBarColor: StatusTheme.statusbarcolor,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        translations: TranslationsApp(),
        locale: Locale('en', 'US'),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'SF Pro',
          scaffoldBackgroundColor: MenuContainer.background,
        ),
        home: MainScreen());
  }
}
