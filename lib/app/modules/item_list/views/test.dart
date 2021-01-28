import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nanglea/app/data/assets.dart';
import 'package:nanglea/app/modules/item_list/controllers/item_list_controller.dart';

class Test extends StatelessWidget {
  const Test({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<ItemListController>(
          init: ItemListController(),
          initState: (_) {},
          builder: (_) {
            return Text(place_des[l[0]].tr);
          },
        ),
      ),
    );
  }
}
