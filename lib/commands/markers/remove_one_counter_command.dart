

import 'package:mtg_roulette/models/player_model.dart';
import 'package:mtg_roulette/commands/base_command.dart';

class RemoveOneCounterCommand extends BaseCommand {

  Future<bool> run(PlayerModel player, String counterTag) async {
    player.removeOneCounter(counterTag);
    return true;
  }
}
