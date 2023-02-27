

import 'package:mtg_roulette/commands/base_command.dart';
import 'package:mtg_roulette/models/dialer_model.dart';

class DialerRemoveDigitCommand extends BaseCommand {
  //DialerAddDigitCommand(context) : super(context);

  Future<void> run(DialerModel dialer) async {
    int newCount = (dialer.count / 10).floor();
    dialer.updateCount(newCount);
  }
}