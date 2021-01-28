import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:nanglea/app/data/assets.dart';

class ItemListController extends GetxController {
  //TODO: Implement ItemListController
  ScrollController scrollController;

  openOnGoogleMapApp(double latitude, double longitude, hardtext) async {
    //ส่งไป app google map เเล้วลากเส้นตำเเหน่งปัจจุบันไปเป้าหมาย
    if (await MapLauncher.isMapAvailable(MapType.apple)) {
      await MapLauncher.showDirections(
        mapType: MapType.apple,
        destination: Coords(latitude, longitude),
        destinationTitle: hardtext,
      );
    }
  }

  Widget buildFab() {
    //starting fab position
    final double defaultTopMargin = 305.0 - 4.0;
    //pixels from top where scaling should start
    final double scaleStart = 96.0;
    //pixels from top where scaling should end
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (scrollController.hasClients) {
      double offset = scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down
        scale = 1.0;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }

    return Positioned(
      top: top,
      right: 16.0,
      child: new Transform(
        transform: new Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: new FloatingActionButton(
          onPressed: () => {
            openOnGoogleMapApp(sets[l[0]][0], sets[l[0]][1], hardtext[l[0]])
          },
          child: new Icon(
            Icons.directions,
            size: 33.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget texthart() {
    final double defaultTopMargin = 305.0 - 4.0;
    //pixels from top where scaling should start
    final double scaleStart = 96.0;
    //pixels from top where scaling should end

    double scale = 0.0;

    if (scrollController.hasClients) {
      double offset = scrollController.offset;

      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down
        scale = 0.0;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 1.0;
      }
    }

    return Transform(
      transform: new Matrix4.identity()..scale(scale), //กำหนดขนาด
      child: Wrap(
        direction: Axis.vertical,
        children: <Widget>[
          Text(hardtext[l[0]].tr,
              style: TextStyle(
                fontFamily: "Kanit",
                color: Colors.white,
                fontSize: 20.0,
              )),
        ],
      ),
    );
  }

  List<Map> items = [
    {"value": 0, "text": 'ภาษาไทย', "lc_sub": "th", "lc": "TH"},
    {"value": 1, "text": 'English', "lc_sub": "en", "lc": "EN"},
    {"value": 2, "text": '日本語', "lc_sub": "jp", "lc": "JP"},
    {"value": 3, "text": '中文', "lc_sub": "cn", "lc": "CN"},
    {"value": 4, "text": '한국어', "lc_sub": "kr", "lc": "KR"},
  ];
  void changeLanguage(var param1, var param2) {
    var locale = Locale(param1, param2);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    super.onInit();
    scrollController = new ScrollController();
    scrollController.addListener(() {
      this.update();
    });
  }

  @override
  void onReady() {}
  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}

class PNetworkImage extends StatelessWidget {
  final String image;
  final BoxFit fit;
  final double width, height;
  const PNetworkImage(this.image, {Key key, this.fit, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      fit: fit,
      width: width,
      height: height,
    );
  }
}
