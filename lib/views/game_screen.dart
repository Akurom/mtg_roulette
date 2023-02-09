import 'package:flutter/material.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'package:mtg_roulette/views/commons/count_widget.dart';
import 'package:provider/provider.dart';
import 'package:mtg_roulette/models/game_model.dart';
import 'commons/center_button.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
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
                            color: gameModel.players[0].color,
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: CountWidget(
                                defaultV: gameModel.players[0].lifeCount,
                                onChanged: (int) {},
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
                                defaultV: gameModel.players[0].lifeCount,
                                onChanged: (int) {},
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
                            color: gameModel.players[2].color,
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: CountWidget(
                                defaultV: gameModel.players[0].lifeCount,
                                onChanged: (int) {},
                              ),
                            ),
                          ),
                          Container(
                            width: getScreenWidth(context) / 2,
                            height: getScreenHeight(context) / 2,
                            color: gameModel.players[3].color,
                            child: RotatedBox(
                              quarterTurns: -1,
                              child: CountWidget(
                                defaultV: gameModel.players[0].lifeCount,
                                onChanged: (int) {},
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
