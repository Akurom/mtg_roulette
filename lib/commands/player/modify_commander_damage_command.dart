
import 'package:mtg_roulette/commands/base_command.dart';
import 'package:mtg_roulette/models/commander_damage_model.dart';

class ModifyCommanderDamageCommand extends BaseCommand {

  Future<void> run(CommanderDamageModel commanderDamage, int mod) async {
    commanderDamage.totalDamage += mod;
  }
}