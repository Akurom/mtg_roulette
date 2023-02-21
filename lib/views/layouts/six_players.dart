import 'package:flutter/material.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'package:mtg_roulette/views/commons/count_widget.dart';
import 'package:provider/provider.dart';
import 'package:mtg_roulette/models/game_model.dart';
import '../commons/center_button.dart';

class SixPlayers extends StatefulWidget {
  const SixPlayers({Key? key}) : super(key: key);

  @override
  State<SixPlayers> createState() => _SixPlayersState();
}

class _SixPlayersState extends State<SixPlayers> {
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
                  // mid button

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Container(
                          /*width: getScreenWidth(context) / 2,
                        height: getScreenHeight(context) / 2,*/
                          color: gameModel.players[0].color,
                          child: RotatedBox(
                            quarterTurns: 2,
                            child: CountWidget(
                              defaultV: gameModel.players[0].lifeCount,
                              player: gameModel.players[0],
                              onChanged: (newCount) {
                                gameModel.players[0].updateLifeCount(newCount);
                              },
                            ),
                          ),
                        ),
                      ),
                      Row(
                        //mainAxisAlignment: ,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Container(
                              width: sw(context) / 2,
                              height: sh(context) * 3 / 10,
                              //color: gameModel.players[0].color,
                              child: RotatedBox(
                                quarterTurns: 1,
                                child: CountWidget(
                                  defaultV: gameModel.players[5].lifeCount,
                                  player: gameModel.players[5],
                                  onChanged: (newCount) {
                                    // todo snackbar then update
                                    gameModel.players[5]
                                        .updateLifeCount(newCount);
                                  },
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Container(
                              width: sw(context) / 2,
                              height: sh(context) * 3 / 10,
                              color: gameModel.players[1].color,
                              child: RotatedBox(
                                quarterTurns: -1,
                                child: CountWidget(
                                  defaultV: gameModel.players[1].lifeCount,
                                  player: gameModel.players[1],
                                  onChanged: (newCount) {
                                    gameModel.players[1]
                                        .updateLifeCount(newCount);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: Container(
                              width: sw(context) / 2,
                              height: sh(context) * 3 / 10,
                              color: gameModel.players[3].color,
                              child: RotatedBox(
                                quarterTurns: 1,
                                child: CountWidget(
                                  defaultV: gameModel.players[4].lifeCount,
                                  player: gameModel.players[4],
                                  onChanged: (newCount) {
                                    gameModel.players[4]
                                        .updateLifeCount(newCount);
                                  },
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Container(
                              width: sw(context) / 2,
                              height: sh(context) * 3 / 10,
                              color: gameModel.players[2].color,
                              child: RotatedBox(
                                quarterTurns: -1,
                                child: CountWidget(
                                  defaultV: gameModel.players[2].lifeCount,
                                  player: gameModel.players[2],
                                  onChanged: (newCount) {
                                    gameModel.players[2]
                                        .updateLifeCount(newCount);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(
                          /*width: getScreenWidth(context) / 2,
                        height: getScreenHeight(context) / 2,*/
                          color: gameModel.players[3].color,
                          child: RotatedBox(
                            quarterTurns: 0,
                            child: CountWidget(
                              defaultV: gameModel.players[3].lifeCount,
                              player: gameModel.players[3],
                              onChanged: (newCount) {
                                gameModel.players[3].updateLifeCount(newCount);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  CenterButton(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
