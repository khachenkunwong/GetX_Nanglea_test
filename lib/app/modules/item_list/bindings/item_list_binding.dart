import 'package:get/get.dart';

import 'package:nanglea/app/modules/item_list/controllers/item_list_controller.dart';

class ItemListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ItemListController>(
      () => ItemListController(),
    );
  }
}
