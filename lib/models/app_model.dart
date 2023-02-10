import 'package:flutter/material.dart';
import 'package:mtg_roulette/constants/colors.dart';

class AppModel extends ChangeNotifier {

  List<Color> colorPalette = [
    AppColors.pastelBlack,
    AppColors.pastelBlue,
    AppColors.pastelGreen,
    AppColors.pastelRed,
    AppColors.pastelOrange,
    AppColors.pastelWhite,
    AppColors.pastelDeepBlue,
    AppColors.pastelLightGreen,
    AppColors.pastelPink,
    AppColors.fluoRed,
    AppColors.fluoBlue,
    AppColors.fluoOrange,
    AppColors.fluoYellow,
  ];


  Future<void> load() async {

  }
}