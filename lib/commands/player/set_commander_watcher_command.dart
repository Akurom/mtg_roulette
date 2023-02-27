

import 'package:mtg_roulette/commands/base_command.dart';
import 'package:mtg_roulette/models/commander_damage_model.dart';
import 'package:mtg_roulette/models/player_model.dart';

class SetCommanderWatchCommand extends BaseCommand {

  Future<void> run(PlayerModel currentPlayer, CommanderDamageModel commander, bool watch) async {
    // first clear
    for(PlayerModel player in gameModel.players) {
      player.setHighlight(false);
      for (CommanderDamageModel cmdD in player.commanderDamages) {
        cmdD.isWatching = false;
      }
    }

    commander.isWatching = watch;
    commander.fromPlayer.setHighlight(watch);
  }
}