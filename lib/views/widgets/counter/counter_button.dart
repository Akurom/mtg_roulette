import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:mtg_roulette/const/colors.dart';

typedef void IntCallback(int c);

class CounterButton extends StatelessWidget {
  final int pace;
  final IntCallback onClicked;

  const CounterButton({Key? key, this.pace = 1, required this.onClicked}) : super(key: key);

  void _handleTap(pace) {
    onClicked(pace);
  }

  @override
  Widget build(BuildContext context) {
    late Timer _timer;

    int modified = 0;
    int factor = 1;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Row(
          mainAxisAlignment: pace > 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Icon(
              (pace > 0) ? Icons.add : Icons.remove,
              color: ColorConstants.main,
              size: Theme.of(context).textTheme.headlineSmall!.fontSize,
            ),
            Text(pace.abs().toString(), style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
        onTap: () {
          onClicked(pace);
        },
        onTapDown: (TapDownDetails details) {
          _timer = Timer.periodic(Duration(milliseconds: 100), (t) {
            modified++;
            factor = exp(modified / 5).toInt();

            _handleTap(pace * factor);
          });
        },
        onTapUp: (TapUpDetails details) {
          modified = 0;
          factor = 1;
          _timer.cancel();
        },
        onTapCancel: () {
          modified = 0;
          factor = 1;
          _timer.cancel();
        },
      ),
    );
  }
}
