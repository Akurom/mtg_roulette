import 'package:flutter/material.dart';
import 'package:mtg_roulette/commands/base_command.dart';
import 'package:mtg_roulette/commands/edit_player_command.dart';
import 'package:mtg_roulette/const/path_constants.dart';
import 'package:mtg_roulette/const/text_constants.dart';
import 'package:mtg_roulette/models/app_model.dart';
import 'package:mtg_roulette/models/player_model.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'package:mtg_roulette/const/color_constants.dart';

class EditPlayerScreen extends StatefulWidget {
  final PlayerModel player;

  EditPlayerScreen({required this.player});

  @override
  State<EditPlayerScreen> createState() => _EditPlayerScreenState();
}

class _EditPlayerScreenState extends State<EditPlayerScreen> {
  late Color _currentColor;
  String? _currentWatermark;
  late PlayerModel _player;
  late TextEditingController _textController;

  @override
  void initState() {
    _currentColor = widget.player.color;
    _currentWatermark = widget.player.watermark;
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
                border: UnderlineInputBorder(
                  borderSide: const BorderSide(color: ColorConstants.main, width: 2.0),),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: ColorConstants.main, width: 2.0),
                ),
              ),
              style: Theme.of(context).textTheme.displayMedium,
              onTap: () {
                _textController.selection =
                    TextSelection(baseOffset: 0, extentOffset: _textController.value.text.length);
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
                          child:
                              (AppModel().colorPalette[index].value == _currentColor.value) ? Icon(Icons.check) : null),
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
            Padding(
              padding: EdgeInsets.all(20),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 8,
                children: List.generate(
                  AppModel().watermarks.length,
                  (index) {
                    return InkWell(
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                            image: DecorationImage(
                              image: AssetImage(AppModel().watermarks[index]),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child:
                              (AppModel().watermarks[index] == _currentWatermark)
                                  ? Icon(Icons.check, color: Colors.white,) : null),
                      onTap: () {
                        setState(() {
                          _currentWatermark = AppModel().watermarks[index];
                        });
                      },
                    );
                  },
                ),
              ),
            ),

            InkWell(
              child: Text(
                TextConstants.save,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              onTap: () {
                EditPlayerCommand().run(widget.player, _textController.text, _currentColor, _currentWatermark);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
