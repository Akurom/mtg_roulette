import 'package:flutter/material.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'package:mtg_roulette/views/widgets/player.dart';
import 'package:provider/provider.dart';
import 'package:mtg_roulette/models/game_model.dart';
import '../widgets/center_menu.dart';

class ThreePlayers extends StatelessWidget {
  const ThreePlayers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameModel gameModel = context.read<GameModel>();

    return Scaffold(
      body: Center(
        child: Container(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    //mainAxisAlignment: ,
                    children: [
                      Container(
                        width: screenWidth(context) / 2,
                        height: screenHeight(context) * 3 / 5,
                        child: Player(
                          axis: Axis.horizontal,
                          alignment: Alignment.topLeft,
                          player: gameModel.players[0],
                        ),
                      ),
                      Container(
                        width: screenWidth(context) / 2,
                        height: screenHeight(context) * 3 / 5,
                        child: Player(
                          axis: Axis.horizontal,
                          alignment: Alignment.topRight,
                          player: gameModel.players[1],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      /*width: getscreenWidth(context),
                        height: getScreenHeight(context) / 3,*/
                      child: Player(
                        axis: Axis.vertical,
                        alignment: Alignment.bottomCenter,
                        player: gameModel.players[2],
                      ),
                    ),
                  ),
                ],
              ),
              CenterButton(top: screenHeight(context) * 3 / 5),
            ],
          ),
        ),
      ),
    );
  }
}
