

import 'package:mtg_roulette/commands/base_command.dart';
import 'package:mtg_roulette/models/counter_model.dart';
import 'package:mtg_roulette/models/player_model.dart';

class ModifyCounterCommand extends BaseCommand {

  Future<bool> run(CounterModel counter, int mod) async {
    counter.updateCount(counter.count + mod);
    return true;
  }
}