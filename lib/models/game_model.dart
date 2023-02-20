
import 'package:flutter/material.dart';
import 'package:mtg_roulette/const/strings.dart';
import 'package:mtg_roulette/models/app_model.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'player_model.dart';



class GameModel extends ChangeNotifier {

  late List<PlayerModel> _players = []; // not final ? when a player dies must remove it ?
  late final int _nbPlayers;
  late final int _initialLifeCount;
  bool _isMenuOpen = false;



  GameModel();

  void init(int nbPlayers, int initialLifeCount) {
    _nbPlayers = nbPlayers; _initialLifeCount = nbPlayers;
    int base = randInt(0, AppModel().colorPalette.length);  // used for default color picks
    for (int p = 0; p < nbPlayers; p ++) {
      _players.add(
          PlayerModel(
              name: TextConstants.defaultPlayerName + '${p + 1}',
              lifeCount: initialLifeCount,
              color: AppModel().colorPalette[(base + p) % AppModel().colorPalette.length]
          )
      );
    }
    notifyListeners();
  }


  get players => _players;



  void toggleMenu() {
    _isMenuOpen = !_isMenuOpen;
    // todo pause clocks
    print (_isMenuOpen);
    notifyListeners();
  }

  bool get isMenuOpen => _isMenuOpen;
}