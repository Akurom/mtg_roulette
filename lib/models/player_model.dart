import 'package:flutter/material.dart';


class PlayerModel extends ChangeNotifier {

  int lifeCount;
  // List<Counter> counters = [];
  Color color;

  PlayerModel({required this.lifeCount, required this.color});
}