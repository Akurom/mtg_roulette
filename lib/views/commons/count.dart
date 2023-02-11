import 'package:flutter/material.dart';
import 'package:mtg_roulette/models/player_model.dart';
import 'package:mtg_roulette/views/commons/count_digits.dart';
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
    // init _count from either default value or player life count
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
    widget.onChanged(_count); // call callback passed by parent
  }

  // callback passed to CountButton
  void _onClicked(int pace) {
    if (pace < 0 && (widget.lowLimit == null || _count > widget.lowLimit!))
      _updateCount(_count + pace);
    if (pace > 0 && (widget.highLimit == null || _count < widget.highLimit!))
      _updateCount(_count + pace);
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.player,
      child: Consumer<PlayerModel?>(builder: (context, player, child) {
        return Row(
          children: [
            CountButton(pace: -1, onClicked: _onClicked),
            CountDigits(count: _count),
            CountButton(pace: 1, onClicked: _onClicked),
          ],
        );
      }),
    );
  }
}
