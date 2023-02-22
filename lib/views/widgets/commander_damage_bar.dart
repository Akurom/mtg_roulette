import 'package:flutter/material.dart';
import 'package:mtg_roulette/commands/toggle_highlight_player_command.dart';
import 'package:mtg_roulette/const/color_constants.dart';
import 'package:mtg_roulette/const/size_constants.dart';
import 'package:mtg_roulette/models/game_model.dart';
import 'package:mtg_roulette/models/player_model.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'package:provider/provider.dart';

class CommanderDamageBar extends StatelessWidget {
  final PlayerModel currentPlayer;

  const CommanderDamageBar({required this.currentPlayer});

  @override
  Widget build(BuildContext context) {
    List<PlayerModel> players = context.select<GameModel, List<PlayerModel>>((game) => game.players);

    return Container(
      width: (screenWidth(context) * SizeConstants.commanderTagWidth).hypotenuse,
      //decoration: BoxDecoration(border: Border.all()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (PlayerModel p in players)
            if (p != currentPlayer) CommanderDamageTag(playerModel: p),
        ],
      ),
    );
  }
}

class CommanderDamageTag extends StatelessWidget {
  final PlayerModel playerModel;

  const CommanderDamageTag({required this.playerModel});

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: AlwaysStoppedAnimation(45 / 360),
      child: Container(
        width: screenWidth(context) * SizeConstants.commanderTagWidth,
        height: screenWidth(context) * SizeConstants.commanderTagWidth,
        decoration: BoxDecoration(
          border: Border.all(color: ColorConstants.main, width: 3.0),
          color: playerModel.color,
        ),
        child: RotationTransition(
          turns: AlwaysStoppedAnimation(-45 / 360),
          child: FractionallySizedBox(
            widthFactor: 0.7,
            child: FittedBox(
              child: InkWell(
                child: Text("0", textAlign: TextAlign.center, style: Theme.of(context).textTheme.displaySmall!),
                onTap: () {
                  // todo reset current highlight
                  ToggleHighlightPlayerCommand().run(playerModel);
                  // todo link counter to this widget value, how?
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
