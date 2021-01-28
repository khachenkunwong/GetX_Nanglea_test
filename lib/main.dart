import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nanglea/UnknownRoutes.dart';
import 'package:nanglea/generated/locales.g.dart';

import 'app/data/assets.dart';
import 'app/routes/app_pages.dart';

void main() {
  MaterialColor materialColor = MaterialColor(0xff93d7e4, color); // สี appbar
  runApp(
    GetMaterialApp(
      theme: ThemeData(
        primarySwatch: materialColor, // สี appbar
      ),
      title: "Application",
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeft,
      unknownRoute: GetPage(name: '/unknownRoute', page: () => UnknownRoutes()),
      translations: AppTranslation(),
      locale: Locale('en', 'EN'), //ภาษา
      fallbackLocale: Locale('en', 'EN'), //ภาษา
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
