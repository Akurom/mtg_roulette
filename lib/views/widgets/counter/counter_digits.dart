import 'package:flutter/material.dart';

class CounterDigits extends StatelessWidget {
  final int count;

  const CounterDigits({Key? key, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Text(
        count.toString(),
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }
}
