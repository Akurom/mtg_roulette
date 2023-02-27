import 'package:flutter/foundation.dart';
import 'package:mtg_roulette/commands/clear_all_highlighted_command.dart';
import 'package:mtg_roulette/tools/tools.dart';

import '../base_command.dart';

class PickRandomPlayerCommand extends BaseCommand {



  Future<bool> run([bool quickly = false]) async {

    await ClearAllHighlightedCommand().run();

    if (menuModel.isPicking) return false;
    // todo find a better way, not recommended to use await in loops

    int ms = 300;
    int chosen = randInt(0, gameModel.players.length);
    if (kDebugMode) print(chosen);

    menuModel.togglePicking();
    if (!quickly) {
      for (int i = 0; i < gameModel.players.length + chosen; i++) {
        int p = (i % gameModel.players.length).toInt();

        gameModel.players[p].toggleHighlight();
        await Future.delayed(Duration(milliseconds: ms));

        if (i != gameModel.players.length + chosen)
          gameModel.players[p].toggleHighlight();
        else {

        }
      }
    }
      
    for (int j = 0; j <= 5; j++) {
      gameModel.players[chosen].toggleHighlight();
      await Future.delayed(Duration(milliseconds: ms));
      gameModel.players[chosen].toggleHighlight();

      if (j == 5)
        await Future.delayed(Duration(milliseconds: 1500));
        gameModel.players[chosen].toggleHighlight();
        //menuModel.togglePicking();
    }
    menuModel.togglePicking();

    return true;
  }
}
