

import 'package:mtg_roulette/commands/base_command.dart';
import 'package:mtg_roulette/models/player_model.dart';

class ToggleHighlightPlayerCommand extends BaseCommand {

  Future<bool> run(PlayerModel player) async {
    player.toggleHighlight();
    return true;
  }
}