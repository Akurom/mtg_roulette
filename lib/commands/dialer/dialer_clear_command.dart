

import 'package:mtg_roulette/commands/base_command.dart';
import 'package:mtg_roulette/models/dialer_model.dart';

class DialerClearCommand extends BaseCommand {
  //DialerAddDigitCommand(context) : super(context);

  Future<void> run(DialerModel dialer) async {
    dialer.updateCount(0);
  }
}