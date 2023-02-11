import 'package:flutter/material.dart';
import 'package:mtg_roulette/models/player_model.dart';
import 'package:provider/provider.dart';
import 'count_button.dart';

typedef void IntCallback(int c);

class Count extends StatefulWidget {
  final PlayerModel? player;
  final IntCallback onChanged;
  final int defaultV;
  final int? lowLimit, highLimit;

  const Count({Key? key,
    this.player,
    required this.onChanged,
    this.lowLimit,
    this.highLimit,
    required this.defaultV,
  }) : super(key: key);

  @override
  State<Count> createState() => _CountState();
}

class _CountState extends State<Count> {

  late int _count;

  @override
  void initState() {
    if (widget.player == null)
      _count = widget.defaultV;
    else
      _count = widget.player!.lifeCount;
    super.initState();
  }


  void _updateCount(int newCount) {
    setState(() {
      _count = newCount;
    });
    widget.onChanged(_count);
  }


  void onClicked(int) {
    if (widget.highLimit == null || _count < widget.highLimit!)
      _updateCount(_count - 1);
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.player,
      child: Consumer<PlayerModel?>(builder: (context, player, child) {
        return Row(
          children: [
            CountButton(pace: -1, onClicked: widget.onChanged),
            Text(player!.lifeCount.toString()),
            CountButton(pace: 1, onClicked: widget.onChanged),
          ],
        );
      }),
    );
  }
}
