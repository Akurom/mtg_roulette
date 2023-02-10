import 'package:flutter/material.dart';


class PlayerModel extends ChangeNotifier {

  String name;
  Color color;
  int lifeCount;
  Map<String, int> countersMap = {};


  PlayerModel({
    required this.name,
    required this.color,
    required this.lifeCount,
  });

  void addOneCounter(String tag) {
    if (countersMap[tag] == null) {
      countersMap[tag] = 1;
    } else {
      countersMap[tag] = countersMap[tag]! + 1;
    }
    notifyListeners();
  }

  void removeCounterTag(String tag) {
    countersMap.remove(tag);
    notifyListeners();
  }
}