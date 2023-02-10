import 'package:flutter/material.dart';
import 'package:mtg_roulette/commands/base_command.dart';
import 'package:mtg_roulette/commands/edit_player_command.dart';
import 'package:mtg_roulette/constants/strings.dart';
import 'package:mtg_roulette/models/app_model.dart';
import 'package:mtg_roulette/models/player_model.dart';
import 'package:mtg_roulette/tools/tools.dart';

class EditPlayerScreen extends StatefulWidget {
  final PlayerModel player;
  EditPlayerScreen({required this.player});

  @override
  State<EditPlayerScreen> createState() => _EditPlayerScreenState();
}

class _EditPlayerScreenState extends State<EditPlayerScreen> {

  late Color _currentColor;
  late PlayerModel _player;
  late TextEditingController textController;

  @override
  void initState() {
    _currentColor = widget.player.color;
    _player = widget.player;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    textController = TextEditingController(text: _player.name);

    return Scaffold(
      backgroundColor: _currentColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Text("Name"),
            // ----- name
            TextField(
              controller: textController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
              style: Theme.of(context).textTheme.headline4,
            ),
            // ----- Colors
            // todo

            // todo size to grid (border around)
            Padding(
              padding: EdgeInsets.all(20),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 8,
                children: List.generate(
                  AppModel().colorPalette.length,
                  (index) {
                    return InkWell(
                      child: Card(
                          color: AppModel().colorPalette[index],
                          child: (AppModel().colorPalette[index] == _currentColor) ? Icon(Icons.check) : null),
                      onTap: () {
                        setState(() {
                          _currentColor = AppModel().colorPalette[index];
                        });
                      },
                    );
                  },
                ),
              ),
            ),
            // ----- background watermark / frame
            // todo
            InkWell(
              child: Text(
                Strings.save,
                style: Theme.of(context).textTheme.headline3,
              ),
              onTap: () {
                EditPlayerCommand().run(widget.player, textController.text, _currentColor);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
