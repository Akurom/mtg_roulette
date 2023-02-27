import 'package:flutter/material.dart';
import 'package:mtg_roulette/const/path_constants.dart';
import 'package:mtg_roulette/const/text_constants.dart';
import 'package:mtg_roulette/models/app_model.dart';
import 'package:mtg_roulette/models/commander_damage_model.dart';
import 'package:mtg_roulette/models/counter_model.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'player_model.dart';

class GameModel extends ChangeNotifier {
  late List<PlayerModel> _players = []; // not final ? when a player dies must remove it ?
  late final int _nbPlayers;
  late final int _initialLifeCount;

  GameModel();

  void init(int nbPlayers, int initialLifeCount) {
    _nbPlayers = nbPlayers;
    _initialLifeCount = nbPlayers;
    //int base = randInt(0, AppModel().colorPalette.length);  // used for default color picks
    List<int> usedColors = [];
    List<int> usedWatermarks = [];
    int colorIndex;
    int watermarkIndex;

    for (int p = 0; p < nbPlayers; p++) {
      do {
        colorIndex = (randInt(0, AppModel().colorPalette.length));
      } while (usedColors.contains(colorIndex));
      usedColors.add(colorIndex);

      do {
        watermarkIndex = randInt(0, AppModel().watermarks.length);
      } while (usedWatermarks.contains(watermarkIndex));
      usedWatermarks.add(watermarkIndex);

      _players.add(PlayerModel(
          name: TextConstants.defaultPlayerName + '${p + 1}',
          lifeCounter: CounterModel(initial: initialLifeCount),
          color: AppModel().colorPalette[colorIndex],
          watermark: AppModel().watermarks[watermarkIndex]));
    }

    // ----- init commander damage
    _players.forEach((player) {
      _players.forEach((p) {
        if (player != p) {
          player.commanderDamages.add(CommanderDamageModel(fromPlayer: p));
        }
      });
    });

    notifyListeners();
  }

  get players => _players;
}
