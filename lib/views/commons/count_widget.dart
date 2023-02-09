import 'package:flutter/material.dart';
import 'package:mtg_roulette/constants/colors.dart';
import 'package:mtg_roulette/models/player_model.dart';
import 'package:mtg_roulette/views/commons/clock.dart';
import 'package:mtg_roulette/views/commons/counters_bar.dart';

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
          // -------- Clock
          if (widget.player != null) Clock(),
          // ---
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: InkWell(
                    child: Icon(
                      Icons.remove,
                    ),
                    onTap: () {
                      if (widget.lowLimit == null || _count > widget.lowLimit!) _updateCount(_count - 1);
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
                  child: InkWell(
                    child: Icon(Icons.add),
                    onTap: () {
                      if (widget.highLimit == null || _count < widget.highLimit!) _updateCount(_count + 1);
                    },
                  ),
                ),
              ],
            ),
          ),
          // --------- Counters bar
          if (widget.player != null) CountersBar(),
          // ---
        ],
      ),
    );
  }
}
