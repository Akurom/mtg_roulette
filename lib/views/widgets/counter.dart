import 'package:flutter/material.dart';
import 'package:mtg_roulette/models/counter_model.dart';
import 'package:mtg_roulette/models/player_model.dart';
import 'package:mtg_roulette/views/widgets/count_digits.dart';
import 'package:provider/provider.dart';
import 'count_button.dart';

class Counter extends StatelessWidget {
  final CounterModel _counterModel;
  final int? lowLimit, highLimit;

  const Counter({
    Key? key,
    required CounterModel model,
    this.lowLimit,
    this.highLimit,
  }) :  _counterModel = model,
        super(key: key);


  void _addCount(int newCount) {

  }

  // callback passed to CountButton
  void _onClicked(int pace) {
    if (pace < 0 && (lowLimit == null || _counterModel.count > lowLimit!))
      _addCount(pace);
    if (pace > 0 && (highLimit == null || _counterModel.count < highLimit!))
      _addCount(pace);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //border: Border.all(),
      ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CountButton(pace: -1, onClicked: _onClicked),
            ChangeNotifierProvider<CounterModel>.value(value: _counterModel,
                child: Consumer<CounterModel>(
                  builder: (context, counter, child) {
                    return CountDigits(count: counter.count);
                  },
                ),
            ),
            CountButton(pace: 1, onClicked: _onClicked),
          ],
      ),
    );
  }
}
