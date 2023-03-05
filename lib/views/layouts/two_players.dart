import 'package:flutter/material.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'package:mtg_roulette/views/widgets/player.dart';
import 'package:provider/provider.dart';
import 'package:mtg_roulette/models/game_model.dart';
import '../widgets/center_menu.dart';

class TwoPlayers extends StatelessWidget {
  const TwoPlayers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameModel gameModel = context.read<GameModel>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          child: Stack(
            children: [
              // mid button

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: screenWidth(context) / 2,
                    height: screenHeight(context) / 2,
                    child: Player(
                      axis: Axis.vertical,
                      alignment: Alignment.topCenter,
                      player: gameModel.players[0],
                    ),
                  ),
                  Container(
                    width: screenWidth(context) / 2,
                    height: screenHeight(context) / 2,
                    child: Player(
                      axis: Axis.vertical,
                      alignment: Alignment.bottomCenter,
                      player: gameModel.players[1],
                    ),
                  ),
                ],
              ),
              CenterButton(),
            ],
          ),
        ),
      ),
    );
  }
}
