import 'package:mtg_roulette/commands/base_command.dart';
import 'package:mtg_roulette/models/player_model.dart';

class ClearAllHighlightedCommand extends BaseCommand {

  Future<bool> run() async {
    for(PlayerModel player in gameModel.players) {
      player.setHighlight(false);
    }
    return true;
  }
}