
import 'package:mtg_roulette/commands/base_command.dart';
import 'package:mtg_roulette/models/game_model.dart';


class CreateGameCommand extends BaseCommand {


  void run(int nbPlayers, int lifeCount) {
    gameModel.init(nbPlayers, lifeCount);
  }
}