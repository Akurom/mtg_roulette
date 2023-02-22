import 'package:flutter/material.dart';
import 'package:mtg_roulette/const/colors.dart';
import 'package:mtg_roulette/models/player_model.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'package:provider/provider.dart';

class DamageSnack extends StatelessWidget {
  final int initialCount;

  const DamageSnack({required this.initialCount});

  @override
  Widget build(BuildContext context) {
    print('snack built');
    return Consumer<PlayerModel>(builder: (context, player, child) {
      return SizedBox(
        width: 0,
        height: 0,
        child: OverflowBox(
          alignment: Alignment.topCenter,
          minHeight: 20,
          minWidth: 50,
          maxHeight: sh(context) / 20,
          maxWidth: sh(context) / 10,
          child: Card(
            color: ColorConstants.black,
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: FittedBox(
                  child: Text(
                      '${player.lifeCount > initialCount ? "+" : player.lifeCount < initialCount ? "-" : ""} ${(player.lifeCount - initialCount).abs()}',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            color: player.lifeCount > initialCount
                                ? Colors.greenAccent
                                : player.lifeCount < initialCount
                                    ? Colors.red
                                    : Colors.white,
                          ))),
            ),
          ),
        ),
      );
    });
  }
}
