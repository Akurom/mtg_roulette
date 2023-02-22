import 'package:flutter/material.dart';
import 'package:mtg_roulette/const/color_constants.dart';
import 'package:mtg_roulette/models/player_model.dart';
import 'package:mtg_roulette/views/screens/edit_player_screen.dart';
import 'package:mtg_roulette/views/widgets/damage_snack.dart';

class TopBar extends StatelessWidget {
  final PlayerModel player;

  TopBar({required this.player});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [


        Flexible(child: Icon(
          Icons.access_time,
          color: ColorConstants.main,
        ),),
        InkWell(
          child: FittedBox(
            child: Text(
              player.name,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditPlayerScreen(player: player)),
            );
          },
        ),

        Flexible(
          child: DamageSnack(initialCount: player.lifeCount, counter: player.lifeCounter,),
        ),
      ],
    );
  }
}
