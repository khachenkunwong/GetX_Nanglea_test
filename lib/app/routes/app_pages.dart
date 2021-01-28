import 'package:get/get.dart';

import 'package:nanglea/app/modules/Map_/bindings/map_binding.dart';
import 'package:nanglea/app/modules/Map_/views/map_view.dart';
import 'package:nanglea/app/modules/home/bindings/home_binding.dart';
import 'package:nanglea/app/modules/home/views/home_view.dart';
import 'package:nanglea/app/modules/item_list/bindings/item_list_binding.dart';
import 'package:nanglea/app/modules/item_list/views/item_list_view.dart';
import 'package:nanglea/app/modules/item_list/views/test.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MAP,
      page: () => MapView(),
      binding: MapBinding(),
    ),
    GetPage(
      name: _Paths.ITEM_LIST,
      page: () => ItemListView(),
      binding: ItemListBinding(),
    ),
    GetPage(
      name: _Paths.TEST,
      page: () => Test(),
    ),
  ];
}
