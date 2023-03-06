
import 'package:mtg_roulette/commands/base_command.dart';

class ToggleMenuCommand extends BaseCommand {

  void run() {
    menuModel.toggleMenu();
  }
}