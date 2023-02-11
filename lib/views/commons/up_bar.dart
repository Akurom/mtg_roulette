

import 'package:flutter/material.dart';
import 'package:mtg_roulette/models/player_model.dart';
import 'package:mtg_roulette/views/edit_player_screen.dart';

class UpBar extends StatelessWidget {

  final PlayerModel player;
  UpBar({required this.player});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(
          Icons.access_time
        ),
        InkWell(
          child: Text(
            player.name,
            style: Theme.of(context).textTheme.headline6,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditPlayerScreen(player: player)),
            );
          },
        ),

        Icon(
          Icons.star_border
        )
      ],
    );
  }
}