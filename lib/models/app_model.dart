import 'package:flutter/material.dart';
import 'package:mtg_roulette/const/colors.dart';
import 'package:mtg_roulette/const/path_constants.dart';

class AppModel extends ChangeNotifier {

  List<Color> colorPalette = [
    //ColorConstants.pastelBlack,
    //ColorConstants.pastelBlue,
    //ColorConstants.pastelGreen,
    ColorConstants.pastelRed,
    ColorConstants.pastelOrange,
    //ColorConstants.pastelWhite,
    ColorConstants.pastelDeepBlue,
    ColorConstants.pastelLightGreen,
    ColorConstants.pastelPink,
    ColorConstants.fluoRed,
    ColorConstants.fluoBlue,
    //ColorConstants.fluoOrange,
    ColorConstants.fluoGreen,
    //ColorConstants.fluoYellow,

    Colors.cyan,
    Colors.redAccent,
    Colors.greenAccent,
    Colors.purpleAccent,
    //Colors.yellow,
    Colors.grey,
    Colors.amber,
  ];

  List<String> watermarks = [
    PathConstants.commander2018,
    PathConstants.tarkir,
    PathConstants.eldraine,
    PathConstants.fifthEdition,
    PathConstants.kaladesh,
    PathConstants.kamigawa,
    PathConstants.knightsVsDragons,
    PathConstants.ravnicaIzzet,
    PathConstants.ravnicaSimic,
    PathConstants.ravnicaTree,
    PathConstants.scourge,
    PathConstants.sun,
    PathConstants.torment,
  ];


  Future<void> load() async {

  }
}