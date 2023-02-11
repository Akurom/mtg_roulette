
import 'package:flutter/material.dart';

class CountDigits extends StatefulWidget {
  final int count;
  const CountDigits({Key? key,  required this.count}) : super(key: key);

  @override
  State<CountDigits> createState() => _CountDigitsState();
}

class _CountDigitsState extends State<CountDigits> {

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.count.toString(),
      style: Theme.of(context).textTheme.headline1,
    );
  }
}