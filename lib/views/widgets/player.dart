import 'package:flutter/material.dart';
import 'package:mtg_roulette/const/color_constants.dart';
import 'package:mtg_roulette/models/counter_model.dart';
import 'package:mtg_roulette/models/player_model.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'package:mtg_roulette/views/widgets/bot_bar.dart';
import 'package:mtg_roulette/views/widgets/clock.dart';
import 'package:mtg_roulette/views/widgets/commander_damage_bar.dart';
import 'package:mtg_roulette/views/widgets/counter/counter.dart';
import 'package:mtg_roulette/views/widgets/counter/counter.dart';
import 'package:mtg_roulette/views/widgets/damage_snack.dart';
import 'package:mtg_roulette/views/widgets/markers_bar.dart';

import 'package:mtg_roulette/views/widgets/top_bar.dart';

import 'package:provider/provider.dart';

typedef void IntCallback(int id);

extension ReverseRowX on List<Widget> {
  List<Widget> setOrderFromAlignment(Alignment alignment) {
    if (alignment == Alignment.bottomRight || alignment == Alignment.topLeft) {
      return this.reversed.toList();
    }
    return this;
  }
}

class Player extends StatefulWidget {
  final PlayerModel player;
  final Axis axis;
  final Alignment alignment;

  const Player({
    Key? key,
    required this.player,
    required this.axis,
    required this.alignment,
  }) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  bool displaySnack = false;

  @override
  void initState() {
    //
    super.initState();
  }

  int _getOrientation() {
    if (widget.alignment == Alignment.topCenter) {
      return 2;
    } else if (widget.alignment == Alignment.bottomCenter) {
      return 0;
    } else if (widget.alignment == Alignment.topLeft) {
      return 1;
    } else if (widget.alignment == Alignment.topRight) {
      return -1;
    } else if (widget.alignment == Alignment.bottomRight) {
      return -1;
    } else if (widget.alignment == Alignment.bottomLeft) {
      return 1;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.player,
      child: Consumer<PlayerModel>(
        builder: (context, player, child) {
          return RotatedBox(
            quarterTurns: _getOrientation(),
            child: Stack(
              children: [
                // ------ watermark
                if (player.watermark != null)
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(player!.watermark!),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),

                // ------ main block
                Container(
                  color: player.color.withOpacity(0.9),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TopBar(player: player),
                      /*if (displaySnack)
                        DamageSnack(initialCount: _initialCount!),*/
                      Container(
                        //decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                        child:  IntrinsicHeight(child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                        Expanded(
                        child: Column(
                                children: [
                                  /*Expanded(
                                    child: */Counter(
                                      model: player.lifeCounter,
                                      paces: [10, 5, 1],
                                    ),

                                  MarkersBar(player: player, axis: widget.axis),
                                ],
                              ),),
                              CommanderDamageBar(currentPlayer: player,),
                            ].setOrderFromAlignment(widget.alignment),
                          ),
                        ),),


                      // --------- Counters bar

                      //Spacer(),

                      // ---
                    ],
                  ),
                ),

                // ----- border
                if (player.isHighlighted) ...[
                  Container(
                    decoration: BoxDecoration(border: Border.all(width: 7.0, color: ColorConstants.main)),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
