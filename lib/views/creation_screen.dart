import 'package:flutter/material.dart';
import 'package:mtg_roulette/constants/strings.dart';


class CreationScreen extends StatefulWidget {
  const CreationScreen({Key? key}) : super(key: key);

  @override
  State<CreationScreen> createState() => _CreationScreenState();
}

class _CreationScreenState extends State<CreationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // players
            Text(Strings.creationPlayersNumber),
            // count widget limit 2:6
            // starting life total
            Text(Strings.creationStartingLife),
            // timer per player
            Text(Strings.creationTimePerPlayer),
          ],
        ),
      ),
    );
  }
}
