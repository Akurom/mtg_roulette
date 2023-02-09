import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtg_roulette/tools/tools.dart';

class Clock extends StatefulWidget {
  Clock({Key? key}) : super(key: key);

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      /*width: getScreenWidth(context) / 8,
      height: getScreenWidth(context) / 8,*/
      child: Center(
        child: InkWell(
          child: Icon(Icons.access_time),
          onTap: () {},
        ),
      ),
    );
  }
}
