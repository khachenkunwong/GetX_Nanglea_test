import 'package:get/get.dart';

import 'package:nanglea/app/modules/Map_/controllers/map_controller.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapController>(
      () => MapController(),
    );
  }
}
