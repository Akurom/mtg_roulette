import 'package:mtg_roulette/commands/base_command.dart';

import 'package:mtg_roulette/models/player_model.dart';

class ToggleDialerCommand extends BaseCommand {

  Future<void> run(PlayerModel player) async {
    player.toggleDialer();
  }
}