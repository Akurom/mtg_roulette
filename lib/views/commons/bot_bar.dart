import 'package:flutter/material.dart';
import 'package:mtg_roulette/commands/add_counter_command.dart';
import 'package:mtg_roulette/commands/remove_one_counter_command.dart';
import 'package:mtg_roulette/commands/clear_counter_command.dart';
import 'package:mtg_roulette/const/colors.dart';
import 'package:mtg_roulette/models/player_model.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class BotBar extends StatefulWidget {
  final PlayerModel player;

  BotBar({Key? key, required this.player}) : super(key: key);

  @override
  State<BotBar> createState() => _BotBarState();
}

class _BotBarState extends State<BotBar> {
  List<String> _setCounterList = []; //['PSN', 'ENR', 'EXP'];
  List<String> _counterList = ['PSN', 'ENR', 'EXP'];
  bool _visible = false;
  IconData _icon = Icons.add_circle_outline;

  void _toggleMenu() {
    if (_visible) {
      setState(() {
        _icon = Icons.add_circle_outline;
        _visible = false;
      });
    } else {
      _icon = Icons.remove_circle_outline;
      setState(() {
        _visible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
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
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //crossAxisAlignment: CrossAxisAlignment.end,

                        children: [
                          AnimatedOpacity(
                            opacity: _visible || player.countersMap['TIX'] != null ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: CounterItem(
                              tag: "TIX",
                              player: player,
                            ),
                          ),
                          AnimatedOpacity(
                            opacity: _visible || player.countersMap['EXP'] != null ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: CounterItem(
                              tag: "EXP",
                              player: player,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Icon(
                        _icon,
                      ),
                      onTap: () {
                        _toggleMenu();
                      },
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //crossAxisAlignment: CrossAxisAlignment.end,

                        children: [
                          AnimatedOpacity(
                            opacity: _visible || player.countersMap['PSN'] != null ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: CounterItem(
                              tag: "PSN",
                              player: player,
                            ),
                          ),
                          AnimatedOpacity(
                            opacity: _visible || player.countersMap['NRG'] != null ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: CounterItem(
                              tag: "NRG",
                              player: player,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
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
        if (player.countersMap[tag] != null) {
          // remove from list and restore in menu
          ClearCounterCommand().run(player, tag);
        }
      },
      onHorizontalDragStart: (DragStartDetails details) {
        if (player.countersMap[tag] != null) {
          RemoveOneCounterCommand().run(player, tag);
        }
      },
      onVerticalDragStart: (DragStartDetails details) {
        if (player.countersMap[tag] != null) {
          RemoveOneCounterCommand().run(player, tag);
        }
      },
      child: Row(
        children: [
          // number of counters
          if (player.countersMap[tag] != null) Text(player.countersMap[tag].toString()),

          Card(
            color: (player.countersMap[tag] != null) ? ColorConstants.black : ColorConstants.white,
            child: Text(
              tag,
              style: TextStyle(color: (player.countersMap[tag] != null) ? ColorConstants.white : ColorConstants.black),
            ),
          ),
        ],
      ),
    );
  }
}
