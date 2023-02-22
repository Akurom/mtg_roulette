

import 'package:mtg_roulette/commands/base_command.dart';

class ToggleMenuReadyCommand extends BaseCommand {

  Future<bool> run() async {
    menuModel.toggleReady();
    return true;
  }
}