import 'dart:ui';

import 'package:get/get.dart';
import 'package:location/location.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  Location location;
  LocationData currentLocation;

  @override
  void onInit() {
    location = new Location(); //ตัว ทำให้มีลูกศอน location ของตัวเอง
    location.onLocationChanged.listen((LocationData cLoc) {
      currentLocation = cLoc;
    });
  }

  @override
  void onReady() {}
  @override
  void onClose() {}
  void increment() => count.value++;
  void changeLanguage(var param1, var param2) {
    var locale = Locale(param1, param2);
    Get.updateLocale(locale);
  }
}
