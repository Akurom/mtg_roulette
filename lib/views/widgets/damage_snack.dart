import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mtg_roulette/const/color_constants.dart';
import 'package:mtg_roulette/const/size_constants.dart';
import 'package:mtg_roulette/models/counter_model.dart';
import 'package:mtg_roulette/models/player_model.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'package:mtg_roulette/views/widgets/counter/counter.dart';
import 'package:provider/provider.dart';

const WIDGET_DECAY_MS = 2000;

class DamageSnack extends StatefulWidget {
  final int initialCount;
  final CounterModel counter;

  const DamageSnack({required this.initialCount, required this.counter});

  @override
  State<DamageSnack> createState() => _DamageSnackState();
}

class _DamageSnackState extends State<DamageSnack> {
  late int _initialCount;
  late Timer _timer;
  late bool _visible;

  @override
  void initState() {
    _initialCount = widget.initialCount;
    _visible = false;
    /*_timer = Timer(Duration(milliseconds: WIDGET_DECAY_MS), () {
      _visible = false;
    });*/
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _refresh(int count) {
    /*_visible = true;
    _timer.cancel();
    _timer = Timer(Duration(milliseconds: WIDGET_DECAY_MS), () {
      _initialCount = count;
      setState(() {
        _visible = false;
      });
      //dispose();
    });
*/
  }


  @override
  Widget build(BuildContext context) {
    print('snack built');


    return ChangeNotifierProvider<CounterModel>.value(
      value: widget.counter,
      child: Consumer<CounterModel>(builder: (context, counter, child) {

        _refresh(counter.count);

        return AnimatedOpacity(
          // If the widget is visible, animate to 0.0 (invisible).
          // If the widget is hidden, animate to 1.0 (fully visible).
          opacity: _visible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          // The green box must be a child of the AnimatedOpacity widget.
          child: Container(
            color: ColorConstants.black,
            width: screenWidth(context) * SizeConstants.damageSnackWidth,
            height: screenWidth(context) * SizeConstants.damageSnackHeight,
            child: /*OverflowBox(
            alignment: Alignment.topCenter,
            minHeight: 20,
            minWidth: 20,
            maxHeight: screenHeight(context) / 10,
            maxWidth: screenHeight(context) / 10,
            child: */
                FractionallySizedBox(
              widthFactor: 0.8,
              child: FittedBox(
                  /*child: RotationTransition(
                    turns: AlwaysStoppedAnimation(-45 / 360),*/
                  child: Text(
                      '${counter.count > _initialCount ? "+" : counter.count < _initialCount ? "-" : ""} ${(counter.count - _initialCount).abs()}',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            color: counter.count > _initialCount
                                ? Colors.greenAccent
                                : counter.count < _initialCount
                                    ? Colors.red
                                    : Colors.white,
                          ))),
            ),
            //),
            //),
          ),
        );
      }),
    );
  }
}
