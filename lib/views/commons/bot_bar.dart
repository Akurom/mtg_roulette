import 'package:flutter/material.dart';
import 'package:mtg_roulette/commands/add_counter_command.dart';
import 'package:mtg_roulette/commands/remove_one_counter_command.dart';
import 'package:mtg_roulette/commands/clear_counter_command.dart';
import 'package:mtg_roulette/constants/colors.dart';
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
                          Visibility(
                            visible: _visible || player.countersMap['TIX'] != null,
                            maintainState: true,
                            maintainAnimation: true,
                            maintainSize: true,
                            child: CounterItem(
                              tag: "TIX",
                              player: player,
                            ),
                          ),
                          Visibility(
                            visible: _visible || player.countersMap['EXP'] != null,
                            maintainState: true,
                            maintainAnimation: true,
                            maintainSize: true,
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
                        Icons.add_circle_outline,
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
                          Visibility(
                            visible: _visible || player.countersMap['PSN'] != null,
                            maintainState: true,
                            maintainAnimation: true,
                            maintainSize: true,
                            child: CounterItem(
                              tag: "PSN",
                              player: player,
                            ),
                          ),
                          Visibility(
                            visible: _visible  || player.countersMap['NRG'] != null,
                            maintainState: true,
                            maintainAnimation: true,
                            maintainSize: true,
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
          if (player.countersMap[tag] != null) Text(player.countersMap[tag].toString()),

          Card(
            color: AppColors.white,
            child: Text(
              tag,
              style: TextStyle(color: AppColors.black),
            ),
          ),
        ],
      ),
    );
  }
}
