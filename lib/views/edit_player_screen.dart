import 'package:flutter/material.dart';
import 'package:mtg_roulette/constants/strings.dart';
import 'package:mtg_roulette/models/player_model.dart';

class EditPlayerScreen extends StatelessWidget {

  final PlayerModel player;
  EditPlayerScreen({required this.player});

  late TextEditingController textController;

  @override
  Widget build(BuildContext context) {

    textController = TextEditingController(text: player.name);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Text("Name"),
            // ----- name
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            // ----- Colors
            // todo
            // ----- background watermark / frame
            // todo
            InkWell(
              child: Text(Strings.save),
              onTap: () {
                // EditPlayerCommand().run();
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
