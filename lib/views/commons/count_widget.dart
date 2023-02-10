import 'package:flutter/material.dart';
import 'package:mtg_roulette/constants/colors.dart';
import 'package:mtg_roulette/models/player_model.dart';
import 'package:mtg_roulette/views/commons/clock.dart';

import 'package:mtg_roulette/views/commons/up_bar.dart';
import 'package:mtg_roulette/views/commons/counters_bar.dart';
import 'dart:async';

import 'package:mtg_roulette/views/commons/player_name.dart';

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

  @override
  void initState() {
    _count = widget.defaultV;
    super.initState();
  }

  void _updateCount(int newCount) {
    setState(() {
      _count = newCount;
    });
    widget.onChanged(_count);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: BoxDecoration(color: widget.color, border: Border.all()),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (widget.player != null) UpBar(player: widget.player!),
          // -------- player name
          //if (widget.player != null) PlayerName(playerName: widget.player!.name),
          // ---
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: GestureDetector (
                    child: Icon(Icons.remove),
                    onTap: () {
                      if (widget.highLimit == null || _count < widget.highLimit!) _updateCount(_count - 1);
                    },
                    onTapDown: (TapDownDetails details) {
                      _timer = Timer.periodic(Duration(milliseconds: 100), (t) {
                        _updateCount(_count - 1);
                      });
                    },
                    onTapUp: (TapUpDetails details) {
                      _timer.cancel();
                    },
                    onTapCancel: () {
                      _timer.cancel();
                    },
                  ),
                ),
                Center(
                  child: Text(
                    _count.toString(),
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Expanded(
                  child: GestureDetector (
                    child: Icon(Icons.add),
                    onTap: () {
                      if (widget.highLimit == null || _count < widget.highLimit!) _updateCount(_count + 1);
                    },
                    onTapDown: (TapDownDetails details) {
                      _timer = Timer.periodic(Duration(milliseconds: 100), (t) {
                        _updateCount(_count + 1);
                      });
                    },
                    onTapUp: (TapUpDetails details) {
                      _timer.cancel();
                    },
                    onTapCancel: () {
                      _timer.cancel();
                    },
                  ),
                ),
              ],
            ),
          ),
          // --------- Counters bar
          if (widget.player != null) CountersBar(player: widget.player!,),
          // ---
        ],
      ),
    );
  }
}
