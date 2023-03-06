import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mtg_roulette/commands/counter/modify_counter_command.dart';
import 'package:mtg_roulette/const/size_constants.dart';
import 'package:mtg_roulette/models/counter_model.dart';
import 'package:mtg_roulette/models/player_model.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'package:mtg_roulette/views/widgets/counter/counter_digits.dart';
import 'package:provider/provider.dart';
import 'counter_button.dart';

typedef void voidCallback();

class Counter extends StatelessWidget {
  final CounterModel _counterModel;
  final int? lowLimit, highLimit;
  final List<int> paces;
  final bool tiny;
  final voidCallback? callback;

  const Counter(
      {Key? key,
      required CounterModel model,
      this.lowLimit,
      this.highLimit,
      this.paces = const [1],
      this.tiny = false,
      this.callback})
      : _counterModel = model,
        super(key: key);

  void _addCount(int mod) {
    ModifyCounterCommand().run(_counterModel, mod);
  }

  // callback passed to CountButton
  void _onClicked(int pace) {
    if (pace < 0 && (lowLimit == null || _counterModel.count > lowLimit!)) _addCount(pace);
    if (pace > 0 && (highLimit == null || _counterModel.count < highLimit!)) _addCount(pace);
  }

  @override
  Widget build(BuildContext context) {
    log('Counter built.');
    return Container(
      height: screenWidth(context) * 3 / 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int pace in paces) CounterButton(pace: -pace, tiny: tiny, onClicked: _onClicked),
            ],
          ),
          ChangeNotifierProvider<CounterModel>.value(
            value: _counterModel,
            child: Consumer<CounterModel>(
              builder: (context, counter, child) {
                return CounterDigits(
                  count: counter.count,
                  callback: callback,
                );
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (int pace in paces) CounterButton(pace: pace, tiny: tiny, onClicked: _onClicked),
            ],
          ),
        ],
      ),
    );
  }
}
