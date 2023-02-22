import 'package:flutter/material.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'package:mtg_roulette/views/widgets/player_widget.dart';
import 'package:provider/provider.dart';
import 'package:mtg_roulette/models/game_model.dart';
import '../widgets/center_menu.dart';

class TwoPlayers extends StatefulWidget {
  const TwoPlayers({Key? key}) : super(key: key);

  @override
  State<TwoPlayers> createState() => _TwoPlayersState();
}

class _TwoPlayersState extends State<TwoPlayers> {
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
                      Container(
                        width: screenWidth(context) / 2,
                        height: screenHeight(context) / 2,
                        //color: gameModel.players[0].color,
                        child: RotatedBox(
                          quarterTurns: 2,
                          child: PlayerWidget(
                            axis: Axis.vertical,
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
                        width: screenWidth(context) / 2,
                        height: screenHeight(context) / 2,
                        color: gameModel.players[1].color,
                        child: RotatedBox(
                          quarterTurns: 0,
                          child: PlayerWidget(
                            axis: Axis.vertical,
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
