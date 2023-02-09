
import 'dart:html';

import 'package:mtg_roulette/commands/base_command.dart';
import 'package:mtg_roulette/models/game_model.dart';


class CreateGameCommand extends BaseCommand {


  Future<bool> run(int nbPlayers, int lifeCount) async {
    gameModel = GameModel(nbPlayers: nbPlayers, initialLifeCount: lifeCount);
    return true;
  }
}