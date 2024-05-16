import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:foodcafe/src/features/orderlengthProvider.dart';
import 'package:foodcafe/src/features/translations.dart';

import 'package:foodcafe/src/screens/main_screen.dart';

import 'package:foodcafe/src/utils/color.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

Future main() async {
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: MenuContainer.background,
    statusBarColor: StatusTheme.statusbarcolor,
  ));
  runApp(const MyApp());
}

Future backgroundHandler(RemoteMessage msg) async {}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrderLengthNotifier(),
      child: GetMaterialApp(
          translations: TranslationsApp(),
          locale: Locale('en', 'US'),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'SF Pro',
            scaffoldBackgroundColor: MenuContainer.background,
          ),
          home: MainScreen()),
    );
  }
}
