import 'package:flutter/material.dart';
import 'package:mtg_roulette/constants/colors.dart';
import 'package:mtg_roulette/constants/strings.dart';
import 'commons/count_widget.dart';

class CreationScreen extends StatelessWidget {
  final Color color;

  CreationScreen({Key? key, this.color = Colors.transparent}) : super(key: key);
/*
  @override
  State<CreationScreen> createState() => _CreationScreenState();
}

class _CreationScreenState extends State<CreationScreen> {*/
  late int _nbPlayers;
  late int _lifeCount;

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
                defaultV: 2,
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
                defaultV: 20,
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
