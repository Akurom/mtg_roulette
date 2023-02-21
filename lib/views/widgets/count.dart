import 'package:flutter/material.dart';
import 'package:mtg_roulette/models/player_model.dart';
import 'package:mtg_roulette/views/widgets/count_digits.dart';
import 'package:provider/provider.dart';
import 'count_button.dart';

typedef void IntCallback(int c);

class Count extends StatefulWidget {
  final PlayerModel? player;
  final IntCallback onChanged;
  final int defaultV;
  final int? lowLimit, highLimit;

  const Count({
    Key? key,
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
  //late int _count;
  late ValueNotifier<int> _count;// = ValueNotifier(0);  // used to build CountDigits

  @override
  void initState() {
    // init _count from either default value or player life count
    if (widget.player == null)
      _count = ValueNotifier(widget.defaultV);
    else
      _count = ValueNotifier(widget.player!.lifeCount);
    super.initState();
  }

  void _updateCount(int newCount) {
    _count.value = newCount;
    widget.onChanged(_count.value); // call callback passed by parent
  }

  // callback passed to CountButton
  void _onClicked(int pace) {
    if (pace < 0 && (widget.lowLimit == null || _count.value > widget.lowLimit!)) _updateCount(_count.value + pace);
    if (pace > 0 && (widget.highLimit == null || _count.value < widget.highLimit!)) _updateCount(_count.value + pace);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //border: Border.all(),
      ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CountButton(pace: -1, onClicked: _onClicked),
            ValueListenableBuilder(
                valueListenable: _count,
                builder: (BuildContext context, int val, Widget? child) {
                  return CountDigits(count: _count.value);
                }),
            CountButton(pace: 1, onClicked: _onClicked),
          ],
        //);
      ),
    );
  }
}
