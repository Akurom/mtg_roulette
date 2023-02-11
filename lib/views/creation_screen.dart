import 'package:flutter/material.dart';
import 'package:mtg_roulette/constants/colors.dart';
import 'package:mtg_roulette/constants/strings.dart';
import 'commons/count_widget.dart';

import 'package:mtg_roulette/commands/create_game_command.dart';

const int DEFAULT_LIFE_COUNT = 20;
const int DEFAULT_NBPLAYERS = 4;

class CreationScreen extends StatelessWidget {
  final Color color;

  CreationScreen({required this.color});

  int _nbPlayers = DEFAULT_NBPLAYERS;
  int _lifeCount = DEFAULT_LIFE_COUNT;

  void _updateNbPlayers(int newNbPlayers) {
    _nbPlayers = newNbPlayers;
  }

  void _updateLifeCount(int newLifeCount) {
    _lifeCount = newLifeCount;
  }

  @override
  Widget build(BuildContext context) {
    print(color);
    return Scaffold(
      body: Center(
        child: Container(
          color: color,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // players
              Text(
                Strings.creationPlayersNumber,
                style: Theme.of(context).textTheme.headline4,
              ),
              // count widget limit 2:6
              CountWidget(
                defaultV: DEFAULT_NBPLAYERS,
                lowLimit: 2,
                highLimit: 6,
                onChanged: _updateNbPlayers,
              ),
              // starting life total
              Text(
                Strings.creationStartingLife,
                style: Theme.of(context).textTheme.headline4,
              ),
              CountWidget(
                defaultV: DEFAULT_LIFE_COUNT,
                lowLimit: 1,
                //color: AppColors.pastelBlack,
                onChanged: _updateLifeCount,
              ),
              // timer per player TODO
              //Text(Strings.creationTimePerPlayer),

              InkWell(
                child: Text(
                  Strings.creationPlay,
                  style: Theme.of(context).textTheme.headline3,
                ),
                onTap: () {
                  // navigate to GameScreen
                  CreateGameCommand().run(_nbPlayers, _lifeCount);
                  Navigator.pushNamed(context, '/game');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
