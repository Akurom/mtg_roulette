import 'package:flutter/material.dart';
import 'dart:async';

typedef void IntCallback(int c);

class CountButton extends StatelessWidget {
  final int pace;
  final IntCallback onClicked;

  const CountButton({Key? key, this.pace = 1, required this.onClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Timer _timer;
    print("CountButton built");
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: SizedBox(child: Icon((pace > 0) ? Icons.add : Icons.remove)),
        onTap: () {
          onClicked(pace);
        },
        onTapDown: (TapDownDetails details) {
          _timer = Timer.periodic(Duration(milliseconds: 100), (t) {
            onClicked(pace);
          });
        },
        onTapUp: (TapUpDetails details) {
          _timer.cancel();
        },
        onTapCancel: () {
          _timer.cancel();
        },
      ),
    );
  }
}
