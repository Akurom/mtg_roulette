
import 'package:mtg_roulette/commands/base_command.dart';
import 'package:mtg_roulette/models/game_model.dart';


class CreateGameCommand extends BaseCommand {


  Future<bool> run(int nbPlayers, int lifeCount) async {
    gameModel.init(nbPlayers, lifeCount);
    return true;
  }
}