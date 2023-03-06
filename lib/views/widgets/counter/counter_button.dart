import 'dart:math' as math;
import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:mtg_roulette/const/color_constants.dart';
import 'package:mtg_roulette/const/size_constants.dart';
import 'package:mtg_roulette/tools/tools.dart';

typedef void IntCallback(int c);

class CounterButton extends StatelessWidget {
  final int pace;
  final bool tiny;
  final IntCallback onClicked;

  const CounterButton({Key? key, this.pace = 1, required this.onClicked, this.tiny = false}) : super(key: key);

  void _handleTap(pace) {
    onClicked(pace);
  }

  @override
  Widget build(BuildContext context) {
    log('CounterButton built.');

    TextStyle textStyle;
    double padding;

    if (tiny) {
      textStyle = Theme.of(context).textTheme.bodyLarge!;
      padding = SizeConstants.tinySmallPaddingRatio;
    } else {
      textStyle = Theme.of(context).textTheme.headlineMedium!;
      padding = SizeConstants.smallPaddingRatio;
    }

    late Timer _timer;

    int modified = 0;
    int factor = 1;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Opacity(
          opacity: 0.5,
          child: Padding(
            padding: (pace < 0)
                ? EdgeInsets.only(left: screenWidth(context) * padding)
                : EdgeInsets.only(right: screenWidth(context) * padding),
            child: Row(
              mainAxisAlignment: pace > 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Icon(
                  (pace > 0) ? Icons.add : Icons.remove,
                  color: ColorConstants.main,
                  size: textStyle.fontSize, //Theme.of(context).textTheme.displaySmall!.fontSize,
                ),
                Text(pace.abs().toString(), style: textStyle /*Theme.of(context).textTheme.displaySmall*/),
              ],
            ),
          ),
        ),
        onTap: () {
          onClicked(pace);
        },
        onTapDown: (TapDownDetails details) {
          _timer = Timer.periodic(Duration(milliseconds: 100), (t) {
            modified++;
            factor = math.exp(modified / 5).toInt();

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
