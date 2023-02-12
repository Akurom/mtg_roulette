import 'package:flutter/material.dart';
import 'package:mtg_roulette/constants/colors.dart';
import 'package:mtg_roulette/models/player_model.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'package:mtg_roulette/views/commons/bot_bar.dart';
import 'package:mtg_roulette/views/commons/clock.dart';
import 'package:mtg_roulette/views/commons/count.dart';

import 'package:mtg_roulette/views/commons/up_bar.dart';
import 'dart:async';

import 'package:provider/provider.dart';

typedef void IntCallback(int id);

class CountWidget extends StatefulWidget {
  final int defaultV;
  final int? lowLimit, highLimit;
  final Color color;
  final bool displaySnack;
  final IntCallback onChanged;
  final PlayerModel? player;

  const CountWidget(
      {Key? key,
      this.lowLimit,
      this.highLimit,
      this.displaySnack = false,
      this.color = Colors.transparent,
      this.player = null,
      required this.defaultV,
      required this.onChanged})
      : super(key: key);

  @override
  State<CountWidget> createState() => _CountWidgetState();
}

class _CountWidgetState extends State<CountWidget> {
  late int _count;
  late Timer _timer;
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

  void _updateCount(int newCount) { // let Count handlle counter ? but how to validate form ? => PROVIDER ?

    _count = newCount;
    widget.onChanged(_count);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.player,
      child: Consumer<PlayerModel?>(builder: (context, player, child) {
        return Container(
          //decoration: BoxDecoration(color: widget.color, border: Border.all()),
          color: _color ?? player!.color,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (widget.player != null) UpBar(player: player! /* widget.player!*/),
              // -------- player name
              //if (widget.player != null) PlayerName(playerName: widget.player!.name),
              // ---
              IntrinsicHeight(
                child: Count(
                  player: widget.player,
                  onChanged: _updateCount,
                  defaultV: widget.defaultV,
                  lowLimit: widget.lowLimit,
                  highLimit: widget.highLimit,
                ),
              ),

              // --------- Counters bar
              if (widget.player != null)
                BotBar(
                  player: widget.player!,
                ),
              // ---
            ],
          ),
        );
      }),
    );
  }
}
