import 'package:flutter/material.dart';
import 'package:mtg_roulette/const/colors.dart';

class AppModel extends ChangeNotifier {

  List<Color> colorPalette = [
    ColorConstants.pastelBlack,
    ColorConstants.pastelBlue,
    ColorConstants.pastelGreen,
    ColorConstants.pastelRed,
    ColorConstants.pastelOrange,
    ColorConstants.pastelWhite,
    ColorConstants.pastelDeepBlue,
    ColorConstants.pastelLightGreen,
    ColorConstants.pastelPink,
    ColorConstants.fluoRed,
    ColorConstants.fluoBlue,
    ColorConstants.fluoOrange,
    ColorConstants.fluoGreen,
    ColorConstants.fluoYellow,

    Colors.cyan,
    Colors.redAccent,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.yellow,
    Colors.grey,
    Colors.amber,
  ];


  Future<void> load() async {

  }
}