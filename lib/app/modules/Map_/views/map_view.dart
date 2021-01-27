import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nanglea/app/data/assets.dart';

import 'package:nanglea/app/modules/Map_/controllers/map_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nanglea/app/modules/item_list/views/item_list_view.dart';
import 'package:search_widget/search_widget.dart';

import 'coffee_model.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:nanglea/app/routes/app_pages.dart';

class MapView extends GetView<MapController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // initialIndex: 1,
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            leading: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                  child: Container(
                    height: 35.0,
                    width: 35.0,
                    child: Image.asset('assets/images/ic_logo_crru.png'),
                  ),
                ),
              ],
            ),
            title: const Text(
              'จัดทำโดยคณะมนุษยศาสตร์ มหาวิทยา\nลัยราชภัฏเชียงรายร่วมกับ เทศบาล\nตำบทนางแล จังหวัดเชียงราย',
              style: TextStyle(
                fontFamily: 'TH Sarabun New',
                fontSize: 8.9,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  underline: SizedBox(),
                  items: controller.items
                      .map((item) => DropdownMenuItem(
                            value: item["value"],
                            child: Row(
                              children: [
                                Text(item["text"]),
                              ],
                            ),
                          ))
                      .toList(),
                  onChanged: (val) {
                    controller.changeLanguage(controller.items[val]["lc_sub"],
                        controller.items[val]["lc"]);
                  },
                  icon: Icon(
                    Icons.translate,
                    color: Colors.white,
                  ),
                ),
              )
            ],
            bottom: TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              tabs: <Widget>[
                Text(
                  "MAP".tr,
                ),
                Text(
                  "LIST".tr,
                ),
              ],
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Center(
                child: storeTab(context, controller),
              ),
              Center(
                child: storeTab01(context, controller),
              )
            ],
          )),
    );
  }
}

Widget storeTab(BuildContext context, controller) {
  Future<LocationData> getCurrentLocation() async {
    print("getCurrentLocation()");
    Location location = Location();
    try {
      return await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        // Permission denied
      }
      return null;
    }
  }

  Future _goToMe() async {
    controller.currentLocation = await getCurrentLocation();
    controller.controller1
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(controller.currentLocation.latitude,
          controller.currentLocation.longitude),
      zoom: 16,
    )));
  }

  moveCameraSearch() {
    ///การกดเลื่อนตาม
    controller.controller1.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            //CameraPosition ใช้อั้นเดียวกันกับค่าเริ่มต้น
            target: coffeeShops[controller.pageController.page.toInt()]
                .locationCoords,
            zoom: 16.0,
            bearing: 45.0,
            tilt: 45.0)));
  }

  return Container(
    child: Column(
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Stack(
            children: [
              GoogleMap(
                zoomControlsEnabled: false,
                myLocationEnabled: true,
                compassEnabled: false,

                mapToolbarEnabled: true, //เเถบเครื่องมือถ้าเป็น จริง
                rotateGesturesEnabled: true, //ตอบสนองการหมุนเมือเเตะ จริง
                scrollGesturesEnabled: true, //ตอบสนองการเลื่อนเมือเเตะ จริง
                zoomGesturesEnabled: true, //ตอบสนองการซูมเมือเเตะ จริง
                tiltGesturesEnabled: false,
                trafficEnabled: true, // เปิดการจราจร จริง
                mapType: MapType.normal,
                markers: Set.from(controller.allMarkers),

                initialCameraPosition: CameraPosition(
                    target: LatLng(20.064509, 99.811011), zoom: 10.0),
                onMapCreated: controller.mapCreated,
              ),
              Positioned(
                bottom: 55.0,
                child: Container(
                  height: 200.0,
                  width: Get.width,
                  child: PageView.builder(
                    controller: controller.pageController,
                    itemCount: coffeeShops.length,
                    itemBuilder: (BuildContext context, int index) {
                      return controller.coffeeShopList(index);
                    },
                  ),
                ),
              ),
              Positioned(
                  left: 15.0,
                  top: 15.0,
                  right: 15.0,
                  child: SearchWidget(
                    dataList: controller.list,
                    listContainerHeight: MediaQuery.of(context).size.height / 4,
                    popupListItemBuilder: (item) {
                      //ทำให้เเสดงรายชื่อได้
                      return Container(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          "${item.username.toString().tr}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                    },
                    textFieldBuilder: (controllerr, focusNode) {
                      return MyTextField(controllerr, focusNode);
                    },
                    noItemsFoundWidget: NoItemsFound(),
                    selectedItemBuilder: (
                      selectedItem,
                      deleteSelectedItem,
                    ) {
                      controller.controller1.animateCamera(
                          CameraUpdate.newCameraPosition(CameraPosition(
                              target: selectedItem.latLngSearch,
                              zoom: 16.0,
                              bearing: 45.0,
                              tilt: 45.0)));
                    },
                    queryBuilder: (query, list) {
                      //เมื่อพิมเจอเเล้ว ตัวเลือกอื้นหาย
                      return list
                          .where((item) => item.username
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                          .toList();
                    },
                    onItemSelected: (item) {
                      controller.selectedItem = item;
                    },
                  )),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget storeTab01(BuildContext context, controller) {
  final List<String> items =
      List<String>.generate(imagess.length, (index) => "${++index}"); //+1
  return Container(
    padding: EdgeInsets.all(1.0),
    child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.67,
        crossAxisCount: 2,
      ),
      itemCount: 16,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () async {
            l.insert(0, index);
            print(l[0]);

            await Future.delayed(Duration(milliseconds: 200));
            Get.toNamed(Routes.ITEM_LIST);

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) {
            //       return ItemListView();
            //     },
            //     fullscreenDialog: true,
            //   ),
            // );
          },
          child: Hero(
            tag: "card${index}",
            child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Container(
                          height: 183.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: ExactAssetImage(imagess[index]),
                            ),
                          ),
                        )),
                    Flexible(
                      flex: 0,
                      fit: FlexFit.tight,
                      child: Wrap(
                        children: <Widget>[
                          ListTile(
                            title: Text('${hardtext[index].tr}',
                                style: TextStyle(
                                  fontFamily: "Kanit",
                                  color: Colors.grey[600],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        );
      },
    ),
  );
}

class NoItemsFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(width: 10),
        Text("Not_found".tr,
            style: TextStyle(
              fontFamily: "Kanit",
              color: Colors.grey[600],
            )),
      ],
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField(this.controller, this.focusNode);

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.0),
        color: Colors.white,
      ),
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Image.asset(
                    'assets/images/ic_search.png',
                    width: 25,
                    height: 25,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: "Search_place".tr,
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 45.0, bottom: 10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
