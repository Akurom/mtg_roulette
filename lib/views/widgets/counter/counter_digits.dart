import 'package:flutter/material.dart';

typedef void VoidCallback();

class CounterDigits extends StatelessWidget {
  final int count;
  final VoidCallback? callback;

  const CounterDigits({Key? key, required this.count, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(
          count.toString(),
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      onLongPress: callback,
    );
  }
}