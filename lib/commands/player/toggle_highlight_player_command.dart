
import 'package:mtg_roulette/commands/base_command.dart';
import 'package:mtg_roulette/commands/player/clear_all_highlighted_command.dart';
import 'package:mtg_roulette/models/player_model.dart';

class ToggleHighlightPlayerCommand extends BaseCommand {

  Future<bool> run(PlayerModel player) async {
    bool set = !player.isHighlighted;
    await ClearAllHighlightedCommand().run();
    player.setHighlight(set);
    return true;
  }
}