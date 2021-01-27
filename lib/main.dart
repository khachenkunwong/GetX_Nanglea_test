import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nanglea/UnknownRoutes.dart';
import 'package:nanglea/generated/locales.g.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
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
