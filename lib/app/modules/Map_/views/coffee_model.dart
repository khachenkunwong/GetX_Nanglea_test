import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nanglea/app/data/assets.dart';
import 'package:nanglea/app/modules/Map_/controllers/map_controller.dart';

class Coffee {
  String shopName;
  String image;
  String description;
  String thumbNail;
  LatLng locationCoords;
  int number;

  Coffee(
      {this.shopName,
      this.description,
      this.thumbNail,
      this.locationCoords,
      this.image,
      this.number});
}

final List<Coffee> coffeeShops = [
  Coffee(
      shopName: hardtext1[0],
      image: 'assets/images/pin_bandum.png',
      description: history1[0],
      locationCoords: LatLng(19.992118, 99.860694),
      number: 0,
      thumbNail: imagess[0]),
  Coffee(
      shopName: hardtext1[1],
      image: 'assets/images/pin_nang_lae_waterfall.png',
      description: history1[1],
      locationCoords: LatLng(20.044707, 99.828704),
      number: 1,
      thumbNail: imagess[1]),
  Coffee(
      shopName: hardtext1[2],
      image: 'assets/images/pin_khun_bun_dai.png',
      description: history1[2],
      locationCoords: LatLng(20.064509, 99.811011),
      number: 2,
      thumbNail: imagess[2]),
  Coffee(
      shopName: hardtext1[3],
      image: 'assets/images/pin_cafe.png',
      description: history1[3],
      locationCoords: LatLng(20.027004, 99.844637),
      number: 3,
      thumbNail: imagess[3]),
  Coffee(
      shopName: hardtext1[4],
      image: 'assets/images/pin_strawberry.png',
      description: history1[4],
      locationCoords: LatLng(20.033889, 99.836202),
      number: 4,
      thumbNail: imagess[4]),
  Coffee(
      shopName: hardtext1[5],
      image: 'assets/images/pin_baan_khun_mor.png',
      description: history1[5],
      locationCoords: LatLng(20.033839, 99.855696),
      number: 5,
      thumbNail: imagess[5]),
  Coffee(
      shopName: hardtext1[6],
      image: 'assets/images/pin_khun_puu.png',
      description: history1[6],
      locationCoords: LatLng(20.015930, 99.520620),
      number: 6,
      thumbNail: imagess[6]),
  Coffee(
      shopName: hardtext1[7],
      image: 'assets/images/pin_doi_din_daeng.png',
      description: history1[7],
      locationCoords: LatLng(20.017781, 99.882237),
      number: 7,
      thumbNail: imagess[7]),
  Coffee(
      shopName: hardtext1[8],
      image: 'assets/images/pin_bankareang.png',
      description: history1[8],
      locationCoords: LatLng(20.019234, 99.889824),
      number: 8,
      thumbNail: imagess[8]),
  Coffee(
      shopName: hardtext1[9],
      image: 'assets/images/pin_som_sunday.png',
      description: history1[9],
      locationCoords: LatLng(19.992970, 99.861781),
      number: 9,
      thumbNail: imagess[9]),
  Coffee(
      shopName: hardtext1[10],
      image: 'assets/images/pin_greenhouse.png',
      description: history1[10],
      locationCoords: LatLng(19.992596, 99.859079),
      number: 10,
      thumbNail: imagess[10]),
  Coffee(
      shopName: hardtext1[11],
      image: 'assets/images/pin_de_angello.png',
      description: history1[11],
      locationCoords: LatLng(19.994223, 99.864782),
      number: 11,
      thumbNail: imagess[11]),
  Coffee(
      shopName: hardtext1[12],
      image: 'assets/images/pin_box_cafe.png',
      description: history1[12],
      locationCoords: LatLng(19.992283, 99.863845),
      number: 12,
      thumbNail: imagess[12]),
  Coffee(
      shopName: hardtext1[13],
      image: 'assets/images/pin_prasang.png',
      description: history1[13],
      locationCoords: LatLng(20.031752, 99.872231),
      number: 13,
      thumbNail: imagess[13]),
  Coffee(
      shopName: hardtext1[14],
      image: 'assets/images/pin_kaiyang.png',
      description: history1[14],
      locationCoords: LatLng(20.032092, 99.873869),
      number: 14,
      thumbNail: imagess[14]),
  Coffee(
      shopName: hardtext1[15],
      image: 'assets/images/pin_nine_cafe.png',
      description: history1[15],
      locationCoords: LatLng(19.993666, 99.864708),
      number: 15,
      thumbNail: imagess[15]),
];
