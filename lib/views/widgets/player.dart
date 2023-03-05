import 'package:flutter/material.dart';
import 'package:mtg_roulette/commands/player/toggle_dialer_command.dart';
import 'package:mtg_roulette/const/color_constants.dart';
import 'package:mtg_roulette/const/size_constants.dart';
import 'package:mtg_roulette/models/counter_model.dart';
import 'package:mtg_roulette/models/player_model.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'package:mtg_roulette/views/widgets/bot_bar.dart';
import 'package:mtg_roulette/views/widgets/commander_damage_bar.dart';
import 'package:mtg_roulette/views/widgets/counter/counter.dart';
import 'package:mtg_roulette/views/widgets/counter/counter.dart';
import 'package:mtg_roulette/views/widgets/damage_snack.dart';
import 'package:mtg_roulette/views/widgets/dialer/dialer.dart';
import 'package:mtg_roulette/views/widgets/markers_bar.dart';

import 'package:mtg_roulette/views/widgets/top_bar.dart';

import 'package:provider/provider.dart';
import 'package:mtg_roulette/views/screens/edit_player_screen.dart';
import 'dart:developer';

typedef void IntCallback(int id);

extension ReverseRowX on List<Widget> {
  List<Widget> setOrderFromAlignment(Alignment alignment) {
    if (alignment == Alignment.bottomRight || alignment == Alignment.topLeft) {
      return this.reversed.toList();
    }
    return this;
  }
}

class Player extends StatelessWidget {
  final PlayerModel player;
  final Axis axis;
  final Alignment alignment;

  const Player({
    Key? key,
    required this.player,
    required this.axis,
    required this.alignment,
  }) : super(key: key);



  int _getOrientation() {
    if (alignment == Alignment.topCenter) {
      return 2;
    } else if (alignment == Alignment.bottomCenter) {
      return 0;
    } else if (alignment == Alignment.topLeft) {
      return 1;
    } else if (alignment == Alignment.topRight) {
      return -1;
    } else if (alignment == Alignment.bottomRight) {
      return -1;
    } else if (alignment == Alignment.bottomLeft) {
      return 1;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    log('Player built.');
    return ChangeNotifierProvider.value(
      value: player,
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
                      Row(
                        // --- header
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: SizedBox.shrink(),
                          ),
                          /* Flexible(
                            child: Icon(
                              Icons.access_time,
                              color: ColorConstants.main,
                            ),
                          ),*/
                          InkWell(
                            child: FittedBox(
                              child: Text(
                                player.name,
                                style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => EditPlayerScreen(player: player)),
                              );
                            },
                          ),
                          Flexible(
                            child: SizedBox.shrink(),
                          ),
                        ], //.setOrderFromAlignment(widget.alignment),
                      ),
                      // --- header

                      // --- damage mode indicator
                      DamageSnack(
                        initialCount: player.lifeCounter.count,
                        alignment: alignment,
                        counter: player.lifeCounter,
                      ),
                      // --- damage mode indicator

                      // --- counter & commander buttons
                      Container(
                        //decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                width: (screenWidth(context) * SizeConstants.commanderTagWidth).hypotenuse,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Counter(
                                      model: player.lifeCounter,
                                      paces: [10, 5, 1],
                                      callback: () {
                                        ToggleDialerCommand().run(player);
                                      }
                                    ),
                                    MarkersBar(player: player, axis: axis),
                                  ],
                                ),
                              ),
                              CommanderDamageBar(
                                currentPlayer: player,
                              ),
                            ].setOrderFromAlignment(alignment),
                          ),
                        ),
                      ),

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

                if (player.showDialer) ...[
                  Container(
                    color: player.color,
                    child: Dialer(player: player),
                  ),
                ]
              ],
            ),
          );
        },
      ),
    );
  }
}
