import 'package:flutter/material.dart';
import 'package:mtg_roulette/commands/markers/add_counter_command.dart';
import 'package:mtg_roulette/commands/markers/remove_one_counter_command.dart';
import 'package:mtg_roulette/commands/markers/clear_counter_command.dart';
import 'package:mtg_roulette/const/colors.dart';
import 'package:mtg_roulette/models/player_model.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'package:provider/provider.dart';
import 'package:mtg_roulette/const/path_constants.dart';

class MarkersBar extends StatefulWidget {
  final PlayerModel player;
  final Axis axis;

  MarkersBar({Key? key, required this.player, required this.axis}) : super(key: key);

  @override
  State<MarkersBar> createState() => _MarkersBarState();
}

class _MarkersBarState extends State<MarkersBar> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: widget.player,
        child: Consumer<PlayerModel>(
          builder: (context, player, child) {
            return Center(
              child: Container(
                margin: EdgeInsets.only(bottom: sw(context) / 33),
                decoration: BoxDecoration(
                    //border: Border.all()
                    ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CounterItem(
                      axis: widget.axis,
                      tag: "TIX",
                      iconPath: PathConstants.ticketCounterIconBlack,
                      player: player,
                    ),
                    CounterItem(
                      axis: widget.axis,
                      tag: "EXP",
                      iconPath: PathConstants.experienceCounterIconBlack,
                      player: player,
                    ),
                    CounterItem(
                      axis: widget.axis,
                      tag: "PSN",
                      iconPath: PathConstants.poisonCounterIconBlack,
                      player: player,
                    ),
                    CounterItem(
                      axis: widget.axis,
                      tag: "NRG",
                      iconPath: PathConstants.energyCounterIconBlack,
                      player: player,
                    ),
                  ],
                ),
              ),
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
    return FractionallySizedBox(
        widthFactor: 0.7,
        child: FittedBox(
            child: Text(player.countersMap[tag].toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: /*player.color*/ Colors.white, fontWeight: FontWeight.bold))));
  }

  List<Widget> _children(context) {
    return [
      Container(
        margin: EdgeInsets.symmetric(horizontal: sw(context) / 40), // change if isSmall todo
          width: sw(context) / 11,
          height: sw(context) / 11,
          decoration: BoxDecoration(
            //color: (player.countersMap[tag] != null) ? ColorConstants.black : ColorConstants.white,
            color: (player.countersMap[tag] != null) ? ColorConstants.black : Colors.white.withOpacity(0.6),
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
