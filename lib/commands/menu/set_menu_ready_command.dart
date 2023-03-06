

import 'package:mtg_roulette/commands/base_command.dart';
import 'package:mtg_roulette/models/menu_model.dart';

class SetMenuReadyCommand extends BaseCommand {

  void run(bool ready) {
    menuModel.ready = ready;
  }
}