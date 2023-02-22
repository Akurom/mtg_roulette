import 'package:flutter/material.dart';
import 'package:mtg_roulette/models/counter_model.dart';



class PlayerModel extends ChangeNotifier {

  String name;
  Color color;
  String? watermark;
  int lifeCount;
  CounterModel lifeCounter;
  Map<String, int> countersMap = {};
  bool isHighlighted = false;


  PlayerModel({
    required this.name,
    required this.color,
    this.watermark,
    required this.lifeCounter,
    required this.lifeCount,
  });


  void updateLifeCount(int newCount) {
    lifeCount = newCount;
  }


  void editPreferences(String name, Color color, String? watermark) {
    this.name = name; this.color = color; this.watermark = watermark;
    notifyListeners();
  }


  void addOneCounter(String tag) {
    if (countersMap[tag] == null) {
      countersMap[tag] = 1;
    } else {
      countersMap[tag] = countersMap[tag]! + 1;
    }
    notifyListeners();
  }
  void removeOneCounter(String tag) {

    if (countersMap[tag] != null) {
      countersMap[tag] = countersMap[tag]! - 1;
    }
    if (countersMap[tag] == 0) {
      clearCounterTag(tag);
    }
    notifyListeners();
  }

  void clearCounterTag(String tag) {
    countersMap.remove(tag);
    notifyListeners();
  }

  void toggleHighlight() {
    isHighlighted = !isHighlighted;
    notifyListeners();
  }
}