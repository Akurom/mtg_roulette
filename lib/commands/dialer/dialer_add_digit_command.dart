

import 'package:mtg_roulette/commands/base_command.dart';
import 'package:mtg_roulette/models/dialer_model.dart';

class DialerAddDigitCommand extends BaseCommand {
  //DialerAddDigitCommand(context) : super(context);

  Future<void> run(DialerModel dialer, int digit) async {
    int newCount = dialer.count * 10 + digit;
    dialer.updateCount(newCount);
  }
}