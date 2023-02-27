

import 'package:mtg_roulette/commands/base_command.dart';
import 'package:mtg_roulette/models/counter_model.dart';
import 'package:mtg_roulette/models/dialer_model.dart';
import 'package:mtg_roulette/models/player_model.dart';

class DialerSetToCounterCommand extends BaseCommand {
  //DialerAddDigitCommand(context) : super(context);

  Future<void> run(DialerModel dialer, PlayerModel player) async {
    player.lifeCounter.updateCount(dialer.count);
  }
}