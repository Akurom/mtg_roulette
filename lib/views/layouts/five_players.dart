import 'package:flutter/material.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'package:mtg_roulette/views/commons/player_widget.dart';
import 'package:provider/provider.dart';
import 'package:mtg_roulette/models/game_model.dart';
import '../commons/center_menu.dart';

class FivePlayers extends StatefulWidget {
  const FivePlayers({Key? key}) : super(key: key);

  @override
  State<FivePlayers> createState() => _FivePlayersState();
}

class _FivePlayersState extends State<FivePlayers> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Consumer<GameModel>(
            builder: (context, gameModel, child) {
              return Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: sw(context) / 2,
                            height: sh(context) * 3 / 8,
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: PlayerWidget(
                                axis: Axis.horizontal,
                                defaultV: gameModel.players[0].lifeCount,
                                player: gameModel.players[0],
                                onChanged: (newCount) {
                                  // todo snackbar then update
                                  gameModel.players[0]
                                      .updateLifeCount(newCount);
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: sw(context) / 2,
                            height: sh(context) * 3 / 8,
                            color: gameModel.players[1].color,
                            child: RotatedBox(
                              quarterTurns: -1,
                              child: PlayerWidget(
                                axis: Axis.horizontal,
                                defaultV: gameModel.players[1].lifeCount,
                                player: gameModel.players[1],
                                onChanged: (newCount) {
                                  gameModel.players[1]
                                      .updateLifeCount(newCount);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: sw(context) / 2,
                            height: sh(context) * 3 / 8,
                            color: gameModel.players[3].color,
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: PlayerWidget(
                                axis: Axis.horizontal,
                                defaultV: gameModel.players[3].lifeCount,
                                player: gameModel.players[3],
                                onChanged: (newCount) {
                                  gameModel.players[3]
                                      .updateLifeCount(newCount);
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: sw(context) / 2,
                            height: sh(context) * 3 / 8,
                            color: gameModel.players[2].color,
                            child: RotatedBox(
                              quarterTurns: -1,
                              child: PlayerWidget(
                                axis: Axis.horizontal,
                                defaultV: gameModel.players[2].lifeCount,
                                player: gameModel.players[2],
                                onChanged: (newCount) {
                                  gameModel.players[2]
                                      .updateLifeCount(newCount);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          /*width: getScreenWidth(context) / 2,
                        height: getScreenHeight(context) / 2,*/
                          color: gameModel.players[4].color,
                          child: RotatedBox(
                            quarterTurns: 0,
                            child: PlayerWidget(
                              axis: Axis.vertical,
                              defaultV: gameModel.players[4].lifeCount,
                              player: gameModel.players[4],
                              onChanged: (newCount) {
                                gameModel.players[4].updateLifeCount(newCount);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  CenterButton(top: sh(context) * 3 / 8),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
