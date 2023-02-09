
import 'package:flutter/material.dart';
import 'package:mtg_roulette/models/app_model.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'player_model.dart';



class GameModel extends ChangeNotifier {

  late final List<PlayerModel> players; // not final ? when a player dies must remove it ?
  final int nbPlayers;
  final int initialLifeCount;

  GameModel({required this.nbPlayers, required this.initialLifeCount}) {

    int base = randInt(0, AppModel().colorPalette.length);  // used for default color picks
    for (int p = 0; p < nbPlayers; p ++) {
      players.add(
          PlayerModel(
              lifeCount: initialLifeCount,
              color: AppModel().colorPalette[(base + p) % AppModel().colorPalette.length]
          )
      );
    }

    notifyListeners();
  }
}