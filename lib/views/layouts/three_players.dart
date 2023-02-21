import 'package:flutter/material.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'package:mtg_roulette/views/widgets/player_widget.dart';
import 'package:provider/provider.dart';
import 'package:mtg_roulette/models/game_model.dart';
import '../widgets/center_menu.dart';

class ThreePlayers extends StatefulWidget {
  const ThreePlayers({Key? key}) : super(key: key);

  @override
  State<ThreePlayers> createState() => _ThreePlayersState();
}

class _ThreePlayersState extends State<ThreePlayers> {
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
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        //mainAxisAlignment: ,
                        children: [
                          Container(
                            width: sw(context) / 2,
                            height: sh(context) * 3 / 5,
                            //color: gameModel.players[0].color,
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
                            height: sh(context) * 3 / 5,
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
                      Expanded(
                          child: Container(
                        /*width: getScreenWidth(context),
                        height: getScreenHeight(context) / 3,*/
                        color: gameModel.players[2].color,
                        child: RotatedBox(
                          quarterTurns: 0,
                          child: PlayerWidget(
                            axis: Axis.vertical,
                            defaultV: gameModel.players[2].lifeCount,
                            player: gameModel.players[2],
                            onChanged: (newCount) {
                              gameModel.players[2].updateLifeCount(newCount);
                            },
                          ),
                        ),
                      )),
                    ],
                  ),

                  CenterButton(top: sh(context) * 3 / 5),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
