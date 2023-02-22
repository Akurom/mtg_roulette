

import 'package:mtg_roulette/commands/base_command.dart';
import 'package:mtg_roulette/models/player_model.dart';

class ModifyLifeCommand extends BaseCommand {

  Future<bool> run(PlayerModel player, int mod) async {
    player.updateLifeCount(player.lifeCount + mod);
    return true;
  }
}