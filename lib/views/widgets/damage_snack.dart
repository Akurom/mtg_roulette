import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mtg_roulette/const/color_constants.dart';
import 'package:mtg_roulette/const/size_constants.dart';
import 'package:mtg_roulette/const/time_constants.dart';
import 'package:mtg_roulette/models/counter_model.dart';
import 'package:mtg_roulette/models/player_model.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'package:mtg_roulette/views/widgets/counter/counter.dart';
import 'package:provider/provider.dart';

class DamageSnack extends StatefulWidget {
  final int initialCount;
  final Alignment alignment;
  final CounterModel counter;

  const DamageSnack({required this.initialCount, required this.alignment, required this.counter});

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
    _timer = Timer(Duration(milliseconds: 0), () {});
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _refresh(int count) {
    _visible = true;
    _timer.cancel();
    _timer = Timer(Duration(milliseconds: TimeConstants.snackDecayMs), ()
    {
      setState(() {
        _visible = false;
      });
    });
  }


  @override
  void setState(VoidCallback fn) {
    _visible = true;
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    print('snack built');

    double width = screenWidth(context) * SizeConstants.damageSnackWidth;
    double height = width;

    return ChangeNotifierProvider<CounterModel>.value(
      value: widget.counter,
      child: Consumer<CounterModel>(builder: (context, counter, child) {
        if (counter.count != _initialCount) _refresh(counter.count);

        return SizedBox(
            width: 0, height: 0,
            child: OverflowBox(
                alignment: Alignment.topCenter,
                maxHeight: screenWidth(context) * SizeConstants.damageSnackWidth,
                maxWidth: screenWidth(context) * SizeConstants.damageSnackWidth,
                child: AnimatedOpacity(
                  onEnd: () {
                    _initialCount = counter.count;
                  },
                  opacity: _visible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: TimeConstants.fadeOutSnackMs),
                  // The green box must be a child of the AnimatedOpacity widget.
                  child: Stack(
                    children: [
                      Container(
                        width: width,
                        height: height,
                        color: ColorConstants.black,
                        // --- transforms to flat losange
                        transform: Matrix4.translationValues(width / 2, 1.0, 1.0) *
                            Matrix4.diagonal3Values(1.0, 0.5, 1.0) *
                            Matrix4.rotationZ(pi / 4),
                        // ---
                      ),
                      Positioned(
                        top: width / 8,
                        child: Container(
                          width: width,
                          height: height / 2,
                          child: FractionallySizedBox(
                            widthFactor: 0.8,
                            child: FittedBox(
                              child: Text(
                                '${counter.count > _initialCount ? "+" : counter.count < _initialCount ? "-" : ""} ${(counter.count - _initialCount).abs()}',
                                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: counter.count > _initialCount
                                          ? Colors.greenAccent
                                          : counter.count < _initialCount
                                              ? Colors.red
                                              : Colors.white,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )));
      }),
    );
  }
}
