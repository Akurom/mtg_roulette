import 'package:flutter/material.dart';
import 'package:mtg_roulette/tools/tools.dart';

class CountersBar extends StatefulWidget {
  CountersBar({Key? key}) : super(key: key);

  @override
  State<CountersBar> createState() => _CountersBarState();
}

class _CountersBarState extends State<CountersBar> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            /*width: getScreenWidth(context) / 8,
            height: getScreenWidth(context) / 8,*/
            child: Center(
              child: InkWell(
                child: Icon(Icons.add_circle_outline),
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
