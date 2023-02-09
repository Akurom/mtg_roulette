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
  ];


  Future<void> load() async {

  }
}