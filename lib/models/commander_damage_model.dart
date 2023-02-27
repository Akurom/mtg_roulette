
import 'package:flutter/material.dart';
import 'package:mtg_roulette/models/player_model.dart';



class CommanderDamageModel extends ChangeNotifier {

  PlayerModel _fromPlayer;
  int _totalDamage;
  bool _isWatching = false;

  set isWatching(bool value) {
    _isWatching = value;
  }
  bool get isWatching => _isWatching;

  CommanderDamageModel({required PlayerModel fromPlayer})
  : _fromPlayer = fromPlayer, _totalDamage = 0;

  PlayerModel get fromPlayer => _fromPlayer;
  int get totalDamage => _totalDamage;

  set totalDamage(int value) {
    _totalDamage = value;
    notifyListeners();
  }
}