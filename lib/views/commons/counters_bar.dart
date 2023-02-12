import 'package:flutter/material.dart';
import 'package:mtg_roulette/commands/add_counter_command.dart';
import 'package:mtg_roulette/commands/remove_one_counter_command.dart';
import 'package:mtg_roulette/commands/clear_counter_command.dart';
import 'package:mtg_roulette/constants/colors.dart';
import 'package:mtg_roulette/models/player_model.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class CountersBar extends StatefulWidget {
  final PlayerModel player;

  CountersBar({Key? key, required this.player}) : super(key: key);

  @override
  State<CountersBar> createState() => _CountersBarState();
}

class _CountersBarState extends State<CountersBar> {
  List<String> _setCounterList = []; //['PSN', 'ENR', 'EXP'];
  List<String> _counterList = ['PSN', 'ENR', 'EXP'];
  bool _visible = false;
  Timer? _timer;

  void _openMenu() {
    //if (_timer != null) _timer!.cancel();
    setState(() {
      _visible = true;
    });
    _timer = Timer(Duration(seconds: 5), () {
      _closeMenu();
    });
  }

  void _closeMenu() {
    if (_timer != null) _timer!.cancel();
    setState(() {
      _visible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      //create: (context) => widget.player,
      value: widget.player,
      child: Consumer<PlayerModel>(
        builder: (context, player, child) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                  //border: Border.all()
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // ---------- Set counters
                  Expanded(
                    flex: 6,
                    child: Container(decoration: BoxDecoration(border: Border.all()),

                    child: Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      runAlignment: WrapAlignment.start,
                      direction: Axis.horizontal, // todo wrap this shit
                      verticalDirection: VerticalDirection.up,

                      children: [
                        for (String c in player.countersMap.keys)
                          CounterItem(
                            player: player,
                            tag: c,
                            count: player.countersMap[c],
                            isInMenu: false,
                          ),
                      ],
                    ),
                  ),),
                  // -------
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: InkWell(
                        child: Icon(
                          Icons.add_circle_outline,
                        ),
                        onTap: () {
                          _openMenu();
                        },
                      ),
                    ),
                  ),
                  // ---------- Menu hidden
                  Expanded(
                    flex: 6,
                    child: Visibility(
                        visible: _visible,
                        maintainState: true,
                        maintainAnimation: true,
                        maintainSize: true,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (String c in _counterList)
                              CounterItem(
                                player: player,
                                tag: c,
                              ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CounterItem extends StatelessWidget {
  final String tag;
  int? count;
  bool isInMenu;
  PlayerModel player;

  CounterItem({required this.tag, required this.player, this.count, this.isInMenu = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AddCounterCommand().run(player, tag);
      },
      onLongPress: () {
        if (!isInMenu) {
          // remove from list and restore in menu
          ClearCounterCommand().run(player, tag);
        }
      },
      onHorizontalDragStart: (DragStartDetails details) {
        if (!isInMenu) {
          RemoveOneCounterCommand().run(player, tag);
        }
      },
      onVerticalDragStart: (DragStartDetails details) {
        if (!isInMenu) {
          RemoveOneCounterCommand().run(player, tag);
        }
      },
      child: Row(
        children: [
          // number of counters
          if (!isInMenu) Text(count.toString()),

          Card(
            color: AppColors.black,
            child: Text(
              tag,
              style: TextStyle(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
