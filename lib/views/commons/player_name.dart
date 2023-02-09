

import 'package:flutter/cupertino.dart';

class PlayerName extends StatelessWidget {
  final String playerName;
  const PlayerName({required this.playerName});

  @override
  Widget build(BuildContext context) {
    return Text(playerName);
  }
}