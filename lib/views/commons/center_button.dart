
import 'package:flutter/material.dart';
import 'package:mtg_roulette/tools/tools.dart';

import 'package:mtg_roulette/constants/colors.dart';


class CenterButton extends StatelessWidget {

  final double? top;
  final double? left;
  const CenterButton({this.top, this.left});

  @override
  Widget build(BuildContext context) {

    // ugly ?
    double _top = top ?? getScreenHeight(context) / 2;
    double _left = left ?? getScreenWidth(context) / 2;

    return Positioned(
      top: _top - getScreenWidth(context) / 16,
      left: _left - getScreenWidth(context) / 16,
      child: RotationTransition(
        turns: new AlwaysStoppedAnimation(45 / 360),
        child: Container(
          width: getScreenWidth(context) / 8,
          height: getScreenWidth(context) / 8,
          decoration: BoxDecoration(
            color: AppColors.centerButton,
            //border: Border.all(),
          ),
          child: RotationTransition(
            turns: new AlwaysStoppedAnimation(-45 / 360),
            child: Icon(
              Icons.menu,
            ),
          ),
        ),
      ),
    );
  }
}