import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:nanglea/app/data/assets.dart';
import 'package:nanglea/app/modules/Map_/views/coffee_model.dart';
import 'package:nanglea/app/modules/Map_/views/map_view.dart';
import 'package:nanglea/app/routes/app_pages.dart';

class MapController extends GetxController {
  //มันมีคำว่า get ในชื่อ

  //TODO: Implement MapController
  TravelList selectedItem;
  //LocationData currentLocation;
  String searchAddr;
  //TabController tabController; // ตัวควบคุม Tab
  PageController pageController;
  int prevPage; //ใช้กับ _onScroll()
  GoogleMapController controller1;
  //Location location;
  double originLatitude = 19.992118;
  double originLongitude = 99.860694;
  List<Marker> allMarkers = [];
  static List numbers = [3];

  List<Map> items = [
    {"value": 0, "text": 'ภาษาไทย', "lc_sub": "th", "lc": "TH"},
    {"value": 1, "text": 'English', "lc_sub": "en", "lc": "EN"},
    {"value": 2, "text": '日本語', "lc_sub": "jp", "lc": "JP"},
    {"value": 3, "text": '中文', "lc_sub": "cn", "lc": "CN"},
    {"value": 4, "text": '한국어', "lc_sub": "kr", "lc": "KR"},
  ];
  Future<String> delayTime() async {
    var txt = await Future.delayed(Duration(seconds: numbers[0]), () {
      return 'data';
    });
    return txt;
  }

  List<TravelList> list = <TravelList>[
    TravelList(
      hardtext[0],
      10,
      0,
      LatLng(19.992118, 99.860694),
    ),
    TravelList(
      hardtext[1],
      22.5,
      1,
      LatLng(20.044707, 99.828704),
    ),
    TravelList(
      hardtext[2],
      24.7,
      2,
      LatLng(20.064509, 99.811011),
    ),
    TravelList(
      hardtext[3],
      22.1,
      3,
      LatLng(20.027004, 99.844637),
    ),
    TravelList(
      hardtext[4],
      22.1,
      4,
      LatLng(20.033889, 99.836202),
    ),
    TravelList(
      hardtext[5],
      22.1,
      5,
      LatLng(20.033839, 99.855696),
    ),
    TravelList(
      hardtext[6],
      22.1,
      6,
      LatLng(20.015930, 99.520620),
    ),
    TravelList(
      hardtext[7],
      22.1,
      7,
      LatLng(20.017781, 99.882237),
    ),
    TravelList(
      hardtext[8],
      22.1,
      8,
      LatLng(20.019234, 99.889824),
    ),
    TravelList(
      hardtext[9],
      22.1,
      9,
      LatLng(19.992970, 99.861781),
    ),
    TravelList(
      hardtext[10],
      22.1,
      10,
      LatLng(19.992596, 99.859079),
    ),
    TravelList(
      hardtext[11],
      22.1,
      11,
      LatLng(19.994223, 99.864782),
    ),
    TravelList(
      hardtext[12],
      22.1,
      12,
      LatLng(19.992283, 99.863845),
    ),
    TravelList(
      hardtext[13],
      22.1,
      13,
      LatLng(20.031752, 99.872231),
    ),
    TravelList(
      hardtext[14],
      22.1,
      14,
      LatLng(20.032092, 99.873869),
    ),
    TravelList(
      hardtext[15],
      22.1,
      15,
      LatLng(19.993666, 99.864708),
    ),
  ];

  Map<int, Color> color = {
    50: Color.fromRGBO(147, 215, 228, .1),
    100: Color.fromRGBO(147, 215, 228, .2),
    200: Color.fromRGBO(147, 215, 228, .3),
    300: Color.fromRGBO(147, 215, 228, .4),
    400: Color.fromRGBO(147, 215, 228, .5),
    500: Color.fromRGBO(147, 215, 228, .6),
    600: Color.fromRGBO(147, 215, 228, .7),
    700: Color.fromRGBO(147, 215, 228, .8),
    800: Color.fromRGBO(147, 215, 228, .9),
    900: Color.fromRGBO(147, 215, 228, 1)
  };
  Future _onTap(element) {
    //เมื่อกด ตัวที่มาคไว้บนเเผนที่ก็จะ เลื่อน
    pageController.animateToPage(element.number,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  void onInit() {
    super.onInit();
    coffeeShops.forEach((element) {
      //coffeeShops คือ file coffee
      allMarkers.add(Marker(
          markerId: MarkerId(element.shopName),
          draggable: false,
          infoWindow: InfoWindow(title: element.shopName),
          // ignore: deprecated_member_use
          icon: BitmapDescriptor.fromAsset(element.image),
          onTap: () {
            _onTap(element);
          },
          position: element.locationCoords));
    });
    pageController = PageController(initialPage: 1, viewportFraction: 0.75)
      ..addListener(_onScroll);

    // location = new Location(); //ตัว ทำให้มีลูกศอน location ของตัวเอง
    // location.onLocationChanged.listen((LocationData cLoc) {
    //   currentLocation = cLoc;
    // });
    //tabController = TabController(vsync: this, length: 2);
    //tabController.addListener(() => this.update());
  }

  void _onScroll() {
    //เวลาเลื่อนเเล้วเลื่อนตาม
    if (pageController.page.toInt() != prevPage) {
      //ถ้าไม่ตรงสถานที่ให้เลือน
      prevPage = pageController.page.toInt();

      moveCamera(); //ใช้กับอันข้างล่าง

    }
  }

  moveCamera() {
    ///การกดเลื่อนตาม
    controller1.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        //CameraPosition ใช้อั้นเดียวกันกับค่าเริ่มต้น
        target: coffeeShops[pageController.page.toInt()].locationCoords,
        zoom: 16.0,
        bearing: 45.0,
        tilt: 45.0)));
  }

  void mapCreated(controller2) {
    controller1 = controller2;
  }

  coffeeShopList(index) {
    //เเถบตัวเลื่อน
    return AnimatedBuilder(
      animation: pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (pageController.position.haveDimensions) {
          //มิติเเถบเลื่อน อันที่เลือกใหญ่กว่าอันที่ไม่ได้เลื่อก
          value = pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            //ความกว้างความยาวของบ็อกตัวเลื่อน
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
        onTap: () async {
          l.insert(0, index);
          await Future.delayed(Duration(milliseconds: 200));
          Get.toNamed(Routes.ITEM_LIST);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) {
          //       return Item();
          //     },
          //     fullscreenDialog: true,
          //   ),
          // );
        },
        child: Stack(children: [
          Center(
              child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 20.0,
                  ),
                  height: 125.0,
                  width: 275.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          offset: Offset(0.0, 4.0),
                          blurRadius: 10.0,
                        ),
                      ]),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white),
                      child: Row(children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Container(
                              height: 90.0,
                              width: 90.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0)),
                                  image: DecorationImage(
                                      image: AssetImage(//NetworkImage(
                                          coffeeShops[index].thumbNail),
                                      fit: BoxFit.cover))),
                        ),
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Text(coffeeShops[index].shopName.tr,
                                        style: TextStyle(
                                          fontSize: 12.5,
                                          fontFamily: "Kanit",
                                          color: Colors.grey[600],
                                        )),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: Container(
                                      width: 170.0,
                                      child: Text(
                                          coffeeShops[index].description.tr,
                                          style: TextStyle(
                                            fontSize: 11.0,
                                            fontFamily: "Kanit",
                                            color: Colors.grey[600],
                                          )),
                                    ),
                                  )
                                ]),
                          ),
                        )
                      ]))))
        ]),
      ),
    );
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    numbers.insert(0, 1);
    //tabController.dispose();
    super.dispose();
  }

  void changeLanguage(var param1, var param2) {
    var locale = Locale(param1, param2);
    Get.updateLocale(locale);
  }
}

class TravelList {
  TravelList(
    this.username,
    this.score,
    this.number,
    this.latLngSearch,
  );
  var latLngSearch;
  final String username;
  final double score;
  final int number;
}
