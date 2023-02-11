import 'package:flutter/material.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'package:mtg_roulette/views/commons/count_widget.dart';
import 'package:provider/provider.dart';
import 'package:mtg_roulette/models/game_model.dart';
import '../commons/center_button.dart';

class FourPlayers extends StatefulWidget {
  const FourPlayers({Key? key}) : super(key: key);

  @override
  State<FourPlayers> createState() => _FourPlayersState();
}

class _FourPlayersState extends State<FourPlayers> {
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
                      Row(
                        //mainAxisAlignment: ,
                        children: [
                          Container(
                            width: getScreenWidth(context) / 2,
                            height: getScreenHeight(context) / 2,
                            //color: gameModel.players[0].color,
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: CountWidget(
                                defaultV: gameModel.players[0].lifeCount,
                                player: gameModel.players[0],
                                onChanged: (newCount) {
                                  // todo snackbar then update
                                  gameModel.players[0].updateLifeCount(newCount);
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: getScreenWidth(context) / 2,
                            height: getScreenHeight(context) / 2,
                            color: gameModel.players[1].color,
                            child: RotatedBox(
                              quarterTurns: -1,
                              child: CountWidget(
                                defaultV: gameModel.players[1].lifeCount,
                                player: gameModel.players[1],
                                onChanged: (newCount) {
                                  gameModel.players[1].updateLifeCount(newCount);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: getScreenWidth(context) / 2,
                            height: getScreenHeight(context) / 2,
                            color: gameModel.players[3].color,
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: CountWidget(
                                defaultV: gameModel.players[3].lifeCount,
                                player: gameModel.players[3],
                                onChanged: (newCount) {
                                  gameModel.players[3].updateLifeCount(newCount);
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: getScreenWidth(context) / 2,
                            height: getScreenHeight(context) / 2,
                            color: gameModel.players[2].color,
                            child: RotatedBox(
                              quarterTurns: -1,
                              child: CountWidget(
                                defaultV: gameModel.players[2].lifeCount,
                                player: gameModel.players[2],
                                onChanged: (newCount) {
                                  gameModel.players[2].updateLifeCount(newCount);
                                },
                              ),
                            ),
                          ),
                        ],
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
