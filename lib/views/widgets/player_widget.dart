import 'package:flutter/material.dart';
import 'package:mtg_roulette/const/colors.dart';
import 'package:mtg_roulette/models/player_model.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'package:mtg_roulette/views/widgets/bot_bar.dart';
import 'package:mtg_roulette/views/widgets/clock.dart';
import 'package:mtg_roulette/views/widgets/count.dart';
import 'package:mtg_roulette/views/widgets/markers_bar.dart';

import 'package:mtg_roulette/views/widgets/top_bar.dart';

import 'package:provider/provider.dart';

typedef void IntCallback(int id);

class PlayerWidget extends StatefulWidget {
  final int defaultV;
  final int? lowLimit, highLimit;
  final Color color;
  final bool displaySnack;
  final IntCallback onChanged;
  final PlayerModel? player;
  final Axis axis;

  const PlayerWidget({Key? key,
    this.lowLimit,
    this.highLimit,
    this.displaySnack = false,
    this.color = Colors.transparent,
    this.player = null,
    required this.axis,
    required this.defaultV,
    required this.onChanged})
      : super(key: key);

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  late int _count;
  late Color? _color;

  @override
  void initState() {
    _count = widget.defaultV;
    if (widget.player != null) {
      _color = null;
    } else {
      _color = widget.color;
    }

    super.initState();
  }

  void _updateCount(int newCount) {
    // let Count handlle counter ? but how to validate form ? => PROVIDER ?

    _count = newCount;
    widget.onChanged(_count);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.player,
      child: Consumer<PlayerModel?>(builder: (context, player, child) {
        return Stack(children: [

          if (player != null && player.watermark != null)
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(player!.watermark!),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),

          Container(
            //decoration: BoxDecoration(color: widget.color, border: Border.all()),
            color: _color ?? player!.color.withOpacity(0.9),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (player != null) ...[
                  if (widget.axis == Axis.vertical)
                    SizedBox(height: sh(context)/20,),
                  TopBar(player: player),
                  if (widget.axis == Axis.vertical) Spacer(),
                ],

                IntrinsicHeight(
                  child: Count(
                    player: player,
                    onChanged: _updateCount,
                    defaultV: widget.defaultV,
                    lowLimit: widget.lowLimit,
                    highLimit: widget.highLimit,
                  ),
                ),

                // --------- Counters bar
                if (player != null) ...[
                  Spacer(),
                  MarkersBar(player: player, axis: widget.axis),
                  Spacer(),
                ],
                // ---
              ],
            ),
          ),
        ]);
      }),
    );
  }
}