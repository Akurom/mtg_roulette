import 'package:flutter/material.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'package:mtg_roulette/views/widgets/player.dart';
import 'package:provider/provider.dart';
import 'package:mtg_roulette/models/game_model.dart';
import '../widgets/center_menu.dart';

class FivePlayers extends StatelessWidget {
  const FivePlayers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    GameModel gameModel = context.read<GameModel>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        width: screenWidth(context) / 2,
                        height: screenHeight(context) * 3 / 8,
                        child: Player(
                          axis: Axis.horizontal,
                          alignment: Alignment.topLeft,
                          player: gameModel.players[0],
                        ),
                      ),
                      Container(
                        width: screenWidth(context) / 2,
                        height: screenHeight(context) * 3 / 8,
                        child: Player(
                          axis: Axis.horizontal,
                          alignment: Alignment.topRight,
                          player: gameModel.players[1],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: screenWidth(context) / 2,
                        height: screenHeight(context) * 3 / 8,
                        child: Player(
                          axis: Axis.horizontal,
                          alignment: Alignment.bottomLeft,
                          player: gameModel.players[4],
                        ),
                      ),
                      Container(
                        width: screenWidth(context) / 2,
                        height: screenHeight(context) * 3 / 8,
                        child: Player(
                          axis: Axis.horizontal,
                          alignment: Alignment.bottomRight,
                          player: gameModel.players[2],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      /*width: getscreenWidth(context) / 2,
                        height: getScreenHeight(context) / 2,*/

                      child: Player(
                        axis: Axis.vertical,
                        alignment: Alignment.bottomCenter,
                        player: gameModel.players[3],
                      ),
                    ),
                  ),
                ],
              ),
              CenterButton(top: screenHeight(context) * 3 / 8),
            ],
          ),
        ),
      ),
    );
  }
}
