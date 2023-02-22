
import 'package:mtg_roulette/commands/base_command.dart';
import 'package:mtg_roulette/models/player_model.dart';



class AddCounterCommand extends BaseCommand {

  Future<bool> run(PlayerModel playerModel, String counterTag) async {
    playerModel.addOneCounter(counterTag);
    return true;
  }
}