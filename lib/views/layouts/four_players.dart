import 'package:flutter/material.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'package:mtg_roulette/views/widgets/player.dart';
import 'package:provider/provider.dart';
import 'package:mtg_roulette/models/game_model.dart';
import '../widgets/center_menu.dart';

class FourPlayers extends StatefulWidget {
  const FourPlayers({Key? key}) : super(key: key);

  @override
  State<FourPlayers> createState() => _FourPlayersState();
}

class _FourPlayersState extends State<FourPlayers> {
  late GameModel gameModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    gameModel = context.read<GameModel>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          child: /*Consumer<GameModel>(
            builder: (context, gameModel, child) {
              return */
              Stack(
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
                        width: screenWidth(context) / 2,
                        height: screenHeight(context) / 2,
                        child: Player(
                          axis: Axis.horizontal,
                          alignment: Alignment.topLeft,
                          player: gameModel.players[0],
                        ),
                      ),
                      Container(
                        width: screenWidth(context) / 2,
                        height: screenHeight(context) / 2,
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
                        height: screenHeight(context) / 2,
                        child: Player(
                          axis: Axis.horizontal,
                          alignment: Alignment.bottomLeft,
                          player: gameModel.players[3],
                        ),
                      ),
                      Container(
                        width: screenWidth(context) / 2,
                        height: screenHeight(context) / 2,
                        child: Player(
                          axis: Axis.horizontal,
                          alignment: Alignment.bottomRight,
                          player: gameModel.players[2],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              CenterButton(),
            ],
            //);
            //},
          ),
        ),
      ),
    );
  }
}
