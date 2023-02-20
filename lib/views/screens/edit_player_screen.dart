import 'package:flutter/material.dart';
import 'package:mtg_roulette/commands/base_command.dart';
import 'package:mtg_roulette/commands/edit_player_command.dart';
import 'package:mtg_roulette/const/strings.dart';
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
  late TextEditingController _textController;

  @override
  void initState() {
    _currentColor = widget.player.color;
    _player = widget.player;
    _textController = TextEditingController(text: _player.name);
    /*_textController.selection = TextSelection(
      baseOffset: 0,
      extentOffset: _player.name.length,
    );*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: _currentColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Text("Name"),
            // ----- name
            TextField(
              controller: _textController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                focusedBorder:OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                ),
              ),
              style: Theme.of(context).textTheme.headline4,
              onTap: () {
                _textController.selection
                = TextSelection(baseOffset: 0, extentOffset: _textController.value.text.length);
              },

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
                          child: (AppModel().colorPalette[index].value == _currentColor.value) ? Icon(Icons.check) : null),
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
                TextConstants.save,
                style: Theme.of(context).textTheme.headline3,
              ),
              onTap: () {
                EditPlayerCommand().run(widget.player, _textController.text, _currentColor);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
