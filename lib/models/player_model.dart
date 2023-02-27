import 'package:flutter/material.dart';
import 'package:mtg_roulette/models/counter_model.dart';



class PlayerModel extends ChangeNotifier {

  String name;
  Color color;
  String? watermark;
  CounterModel lifeCounter;
  Map<String, int> countersMap = {};
  List commanderDamages = [];
  bool isHighlighted = false;
  bool _showDialer = false;


  PlayerModel({
    required this.name,
    required this.color,
    this.watermark,
    required this.lifeCounter,
    //required this.lifeCount,
  });


  void editPreferences(String name, Color color, String? watermark) {
    this.name = name; this.color = color; this.watermark = watermark;
    notifyListeners();
  }

  // ----- Commander damage
  void initCommanderDamage(players) {

  }

  // ----- COUNTERS (markers)
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
  void setHighlight(bool value) {
    isHighlighted = value;
    notifyListeners();
  }

  bool get showDialer => _showDialer;
  void toggleDialer() {
    _showDialer = !_showDialer;
    notifyListeners();
  }
}