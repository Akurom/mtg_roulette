import 'package:flutter/material.dart';
import 'package:mtg_roulette/const/color_constants.dart';
import 'package:mtg_roulette/const/path_constants.dart';
import 'package:mtg_roulette/const/text_constants.dart';
import 'package:mtg_roulette/models/app_model.dart';
import 'package:mtg_roulette/models/counter_model.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'package:mtg_roulette/views/widgets/counter/counter.dart';
import 'package:provider/provider.dart';


import 'package:mtg_roulette/commands/create_game_command.dart';

const int DEFAULT_LIFE_COUNT = 20;
const int DEFAULT_NBPLAYERS = 4;

class LifeCounterModel extends CounterModel {
  LifeCounterModel({int? initial}) : super(initial: initial);
}

class PlayerCounterModel extends CounterModel {
  PlayerCounterModel({int? initial}) : super(initial: initial);
}

class CreationScreen extends StatelessWidget {
  final Color color = AppModel().colorPalette[randInt(0, AppModel().colorPalette.length)];

  CreationScreen();

  LifeCounterModel _lifeCounter = LifeCounterModel(initial: DEFAULT_LIFE_COUNT);
  PlayerCounterModel _playersCounter = PlayerCounterModel(initial: DEFAULT_NBPLAYERS);

  @override
  Widget build(BuildContext context) {
    print(color);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<PlayerCounterModel>.value(value: _playersCounter),
          ChangeNotifierProvider<LifeCounterModel>.value(value: _lifeCounter),
        ],
        builder: (context, child) {
          return Scaffold(
            body: Container(
              width: screenWidth(context),
              height: screenHeight(context),
              color: color,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // players
                  Text(
                    TextConstants.creationPlayersNumber,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  // count widget limit 2:6
                  Counter(
                    model: _playersCounter,
                    lowLimit: 2,
                    highLimit: 6,
                    //onChanged: _updateNbPlayers,
                  ),

                  // starting life total
                  Text(
                    TextConstants.creationStartingLife,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Counter(
                    model: _lifeCounter,
                    lowLimit: 1,
                  ),

                  InkWell(
                    child: Text(
                      TextConstants.creationPlay,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    onTap: () {
                      int _nbPlayers = context.read<PlayerCounterModel>().count;
                      int _lifeCount = context.read<LifeCounterModel>().count;

                      CreateGameCommand().run(_nbPlayers, _lifeCount);
                      if (_nbPlayers == 2) {
                        Navigator.pushNamed(context, '/two');
                      } else if (_nbPlayers == 3) {
                        Navigator.pushNamed(context, '/three');
                      } else if (_nbPlayers == 4) {
                        Navigator.pushNamed(context, '/four');
                      } else if (_nbPlayers == 5) {
                        Navigator.pushNamed(context, '/five');
                      } else if (_nbPlayers == 6) {
                        Navigator.pushNamed(context, '/six');
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
