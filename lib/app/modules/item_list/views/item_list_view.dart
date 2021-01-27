import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nanglea/app/data/assets.dart';

import 'package:nanglea/app/modules/item_list/controllers/item_list_controller.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ItemListView extends GetView<ItemListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            controller: controller.scrollController,
            slivers: <Widget>[
              SliverAppBar(
                leading: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                title: Text(hardtext[l[0]].tr,
                    style: TextStyle(
                        fontFamily: "Kanit",
                        color: Colors.white,
                        fontSize: 20.0)),
                expandedHeight: 300.0,
                floating: false,
                pinned: true,
                snap: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Item_list(context, controller),
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
                        controller.changeLanguage(
                            controller.items[val]["lc_sub"],
                            controller.items[val]["lc"]);
                      },
                      icon: Icon(
                        Icons.translate,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Wrap(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),
                          alignment: FractionalOffset.topLeft,
                          child: Text(
                            name[l[0]].tr,
                            style: TextStyle(
                              fontFamily: "Kanit",
                              fontSize: 23.0,
                              color: Colors.black,
                            ),
                          )),
                      Container(
                          alignment: FractionalOffset.topLeft,
                          child: Wrap(
                            children: <Widget>[
                              Text(
                                history[l[0]].tr,

                                ///
                                style: TextStyle(
                                    fontFamily: "Kanit",
                                    fontSize: 14.00,
                                    color: Colors.black),
                              ),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 19.0, 0.0, 0.0),
                        child: Container(
                            alignment: FractionalOffset.topLeft,
                            child: Wrap(
                              children: <Widget>[
                                Text(
                                  "เวลาทำการ : ",
                                  style: TextStyle(
                                      fontFamily: "Kanit",
                                      fontSize: 14.00,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  time_available[l[0]].tr,
                                  style: TextStyle(
                                      fontFamily: "Kanit",
                                      fontSize: 14.00,
                                      color: Colors.black),
                                ),
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 19.0, 0.0, 0.0),
                        child: Container(
                            alignment: FractionalOffset.topLeft,
                            child: Wrap(
                              children: <Widget>[
                                Text(
                                  "ที่ตั้ง : ",
                                  style: TextStyle(
                                      fontFamily: "Kanit",
                                      fontSize: 14.00,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  place_des[l[0]].tr, /////
                                  style: TextStyle(
                                      fontFamily: "Kanit",
                                      fontSize: 14.00,
                                      color: Colors.black),
                                ),
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 19.0, 0.0, 0.0),
                        child: Container(
                            alignment: FractionalOffset.topLeft,
                            child: Wrap(
                              children: <Widget>[
                                Text(
                                  "เบอร์โทร : ",
                                  style: TextStyle(
                                      fontFamily: "Kanit",
                                      fontSize: 14.00,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  phone[l[0]],

                                  ///
                                  style: TextStyle(
                                    fontFamily: "Kanit",
                                    fontSize: 14.00,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 19.0, 0.0, 0.0),
                        child: Container(
                            alignment: FractionalOffset.topLeft,
                            child: Wrap(
                              children: <Widget>[
                                Text(
                                  "ข้อมูลทั่วไป : ", //"http://www.thawan-duchanee.com \nอัตราค่าเข้าชม 80 บาท ทั้งชาวไทยและ\nชาวต่างชาติ",
                                  style: TextStyle(
                                      fontFamily: "Kanit",
                                      fontSize: 14.00,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Linkify(
                                  onOpen: (link) async {
                                    if (await canLaunch(link.url)) {
                                      await launch(link.url);
                                    } else {
                                      throw '$link';
                                    }
                                  },
                                  text: note[l[0]].tr, ////
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Kanit",
                                    fontSize: 14.00,
                                  ),
                                  linkStyle: TextStyle(color: Colors.blue),
                                ),
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 19.0, 0.0, 0.0),
                        child: Column(
                          children: <Widget>[
                            Wrap(
                              children: <Widget>[
                                Container(
                                  height: 35.0,
                                  width: 35.0,
                                  child: Image.asset(
                                      'assets/images/ic_logo_crru.png'),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    'จัดทำโดยคณะมนุษยศาสตร์ มหาวิทยาลัยราชภัฏเชียงราย\nร่วมกับ เทศบาลตำบทนางแล จังหวัดเชียงราย',
                                    style: TextStyle(
                                      fontFamily: 'Kanit',
                                      fontSize: 10,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 220.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          //controller.buildFab(),
        ],
      ),
    );
  }
}

Widget Item_list(BuildContext context, controller) {
  return SafeArea(
    child: Column(
      children: <Widget>[
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Container(
            height: 300.0,
            child: Swiper(
              loop: false,
              itemBuilder: (BuildContext context, int inum) {
                return PNetworkImage(
                  //network_image.dart

                  u[l[0]][inum],
                  height: 300.0,
                  fit: BoxFit.cover,
                );
              },
              itemCount: u[l[0]].length, // กำหนดจุด
              pagination: SwiperPagination(
                  builder: SwiperPagination.dots,
                  margin: EdgeInsets.all(
                      8.0)), // package:flutter_swiper ทำให้มีจุดเลือน
            ),
          ),
        ),
      ],
    ),
    //ตัวเลือน
  );
}
