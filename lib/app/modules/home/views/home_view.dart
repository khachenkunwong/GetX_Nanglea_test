import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nanglea/Animation/FadeAnimation.dart';

import 'package:nanglea/app/modules/home/controllers/home_controller.dart';
import 'package:nanglea/app/routes/app_pages.dart';

//controller.changeLanguage('th', 'TH');
class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SafeArea(
            child: Center(
                child: Column(
          children: <Widget>[
            FadeAnimation(
              1,
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Container(
                  width: 350.0,
                  height: 230.0,
                  child: Image.asset("assets/images/icon_nanglae_logo.png"),
                ),
              ),
            ),
            FadeAnimation(
              1.2,
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "Welcome to Nanglae",
                  style: TextStyle(
                      fontFamily: "Arial",
                      fontSize: 20.00,
                      color: const Color(0xff0990b7),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            FadeAnimation(
              1.3,
              Padding(
                padding: const EdgeInsets.only(top: 13.0),
                child: SizedBox(
                  width: 250.0,
                  height: 50.0,
                  child: CupertinoButton(
                      color: const Color(0xff4990e2),
                      // disabledColor: const Color(0xff4990e2),
                      child: Text(
                        "ภาษาไทย",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Arial",
                            fontSize: 20.00,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        controller.changeLanguage('th', 'TH');
                        Get.toNamed(Routes.MAP);
                      }),
                ),
              ),
            ),
            FadeAnimation(
              1.4,
              Padding(
                padding: const EdgeInsets.only(top: 13.0),
                child: SizedBox(
                  width: 250.0,
                  height: 50.0,
                  child: CupertinoButton(
                      color: const Color(0xff4990e2),
                      child: Text(
                        "English",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Arial",
                            fontSize: 18.00,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        controller.changeLanguage('en', 'EN');
                        Get.toNamed(Routes.MAP);
                      }),
                ),
              ),
            ),
            FadeAnimation(
              1.5,
              Padding(
                padding: const EdgeInsets.only(top: 13.0),
                child: SizedBox(
                  width: 250.0,
                  height: 50.0,
                  child: CupertinoButton(
                      color: const Color(0xff4990e2),
                      child: Text(
                        "日本語",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Arial",
                            fontSize: 18.00,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        controller.changeLanguage('jp', 'JP');
                        Get.toNamed(Routes.MAP);
                      }),
                ),
              ),
            ),
            FadeAnimation(
              1.6,
              Padding(
                padding: const EdgeInsets.only(top: 13.0),
                child: SizedBox(
                  width: 250.0,
                  height: 50.0,
                  child: CupertinoButton(
                      color: const Color(0xff4990e2),
                      child: Text(
                        "中文",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Arial",
                            fontSize: 18.00,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        controller.changeLanguage('cn', 'CN');
                        Get.toNamed(Routes.MAP);
                      }),
                ),
              ),
            ),
            FadeAnimation(
              1.7,
              Padding(
                padding: const EdgeInsets.only(top: 13.0),
                child: SizedBox(
                  width: 250.0,
                  height: 50.0,
                  child: CupertinoButton(
                      color: const Color(0xff4990e2),
                      child: Text(
                        "한국어",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Arial",
                            fontSize: 18.00,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        controller.changeLanguage('kr', 'KR');
                        Get.toNamed(Routes.MAP);
                      }),
                ),
              ),
            ),
          ],
        ))),
      ),
    );
  }
}
