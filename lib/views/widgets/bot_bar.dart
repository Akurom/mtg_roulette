import 'package:flutter/material.dart';
import 'package:mtg_roulette/commands/markers/add_counter_command.dart';
import 'package:mtg_roulette/commands/markers/remove_one_counter_command.dart';
import 'package:mtg_roulette/commands/markers/clear_counter_command.dart';
import 'package:mtg_roulette/const/color_constants.dart';
import 'package:mtg_roulette/models/player_model.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:mtg_roulette/const/path_constants.dart';

class BotBar extends StatefulWidget {
  final PlayerModel player;
  final Axis axis;

  BotBar({Key? key, required this.player, required this.axis}) : super(key: key);

  @override
  State<BotBar> createState() => _BotBarState();
}

class _BotBarState extends State<BotBar> {
  bool _visible = true;
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
                /*child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,*/
                  //crossAxisAlignment: CrossAxisAlignment.end,

                  /*children: [*/
                    //child: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //crossAxisAlignment: CrossAxisAlignment.end,

                        children: [
                          AnimatedOpacity(
                            opacity: _visible || player.countersMap['TIX'] != null ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: CounterItem(
                              axis: widget.axis,
                              tag: "TIX",
                              iconPath: PathConstants.ticketCounterIconBlack,
                              player: player,
                            ),
                          ),
                          AnimatedOpacity(
                            opacity: _visible || player.countersMap['EXP'] != null ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: CounterItem(
                              axis: widget.axis,
                              tag: "EXP",
                              iconPath: PathConstants.experienceCounterIconBlack,
                              player: player,
                            ),
                          ),
                        /*],
                      ),
                    ),
                    *//*InkWell(
                      child: Icon(
                        _icon,
                      ),
                      onTap: () {
                        _toggleMenu();
                      },
                    ),*//*
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //crossAxisAlignment: CrossAxisAlignment.end,

                        children: [*/
                          AnimatedOpacity(
                            opacity: _visible || player.countersMap['PSN'] != null ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: CounterItem(
                              axis: widget.axis,
                              tag: "PSN",
                              iconPath: PathConstants.poisonCounterIconBlack,
                              player: player,
                            ),
                          ),
                          AnimatedOpacity(
                            opacity: _visible || player.countersMap['NRG'] != null ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: CounterItem(
                              axis: widget.axis,
                              tag: "NRG",
                              iconPath: PathConstants.energyCounterIconBlack,
                              player: player,
                            ),
                          ),
                        ],
                      ),
                    ),
                 /* ],
                ),*/
              //),
            );
          },
        ));
  }
}

// ================= COUUTER ITEM ==================
class CounterItem extends StatelessWidget {
  Axis axis;
  final String tag;
  final String iconPath;
  int? count;
  bool isInMenu;
  PlayerModel player;

  CounterItem(
      {required this.axis,
      required this.tag,
      required this.iconPath,
      required this.player,
      this.count,
      this.isInMenu = true});

  Widget _counter(context) {
    return
        FractionallySizedBox(
            widthFactor: 0.7,
            child: FittedBox(

                    child: Text(player.countersMap[tag].toString(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: /*player.color*/Colors.white, fontWeight: FontWeight.bold))));

  }

  List<Widget> _children(context) {
    return [
      // number of counters
      /*if (player.countersMap[tag] != null)
        Text(player.countersMap[tag].toString(), style: Theme.of(context).textTheme.displaySmall),*/

      Container(
          width: screenWidth(context) / 11,
          height: screenWidth(context) / 11,
          decoration: BoxDecoration(
            //color: (player.countersMap[tag] != null) ? ColorConstants.black : ColorConstants.white,
            color: (player.countersMap[tag] != null) ? ColorConstants.black : Colors.white,
            shape: BoxShape.circle,
            //border: Border.all(/*color: */),
            image: DecorationImage(
              image: AssetImage(iconPath),
              fit: BoxFit.fitHeight,
            ),
          ),
          child: (player.countersMap[tag] != null) ? _counter(context) : SizedBox.shrink()),
    ];
  }

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
      child: Builder(builder: (context) {
        if (axis == Axis.horizontal)
          return Row(
            children: _children(context).reversed.toList(),
          );
        else
          return Column(
            children: _children(context),
          );
      }),
    );
  }
}
